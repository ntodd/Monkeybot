# TODO: add timestamps each time the status_message is changed
# TODO: add some tabbing to status output for better readability
# TODO: move to a plugin architecture

COMMANDS = ['topic', 'toggle', 'away', 'status', 'status (message)', 'chuck', 'finger (full user name)', 'weather (zip code)']

require File.join(File.dirname(__FILE__), 'init' )

campfire = Tinder::Campfire.new ACCOUNT, :token => LOGIN
room = campfire.find_room_by_name ROOM

room.listen do |message|

  puts message.inspect
  
  user = User.find_or_create_by_name(message[:user][:name])
  user.update_attributes( :status => "active" )

  # ======================
  # = Message operations =
  # ======================

  # Archive messages
  unless MESSAGE_EXCEPTIONS.include?(message[:user][:name])
    unless message[:body] == ""
      user.messages << Message.new( :message => message[:body], :message_id => message[:id] )
      user.save
    end
  end

  # Auto-back feature
  if user.status == "away" and message[:body] !~ /^\/away(\s(.+))?/ and message[:body] !~ /has left the room/
    user.update_attributes( :status => "active" )
  end

  # auto-away status
  if message[:body] =~ /has left the room/
    user.update_attributes( :status => "away", :status_message => "" )
  end

  # Auto-active status
  if message[:body] =~ /has entered the room/
    user.update_attributes( :status => "active" )
  end

  # ===========
  # = /help =
  # ===========
  if message[:body] == "/help"
    room.speak "received help command"
    ret = "I can respond to the following commands:\r\n"
    COMMANDS.each do |command|
      ret << "  #{command}"
      ret << "\r\n"
    end
    ret << "* commands are preceeded by a forward slash (i.e. /command)"
    room.paste ret
  end

  # =====================
  # = /topic room topic =
  # =====================
  if message[:body] =~ /^\/topic\s(.+)/
    room.topic = $1
  end

  # ========================
  # = /toggle guest access =
  # ========================
  if message[:body] == "/toggle guest access"
    room.toggle_guest_access
  end

  # =================
  # = /away message =
  # =================
  if message[:body] =~ /^\/away(\s(.+))?/
    user.status = "away"
    user.status_message = $2 if $2
    if user.save
      if $2
        room.speak message[:user][:name] + " is now away: #{$2}"
      else
        room.speak message[:user][:name] + " is now away"
      end
    else
      room.speak "Oops, problem."
    end
  end

  # ===================
  # = /status message =
  # ===================
  if message[:body] =~ /^\/status\s(.+)?/
    user.status_message = $1
    if user.save
      room.speak "#{message[:user][:name]} is currently #{user.status}: #{user.status_message}"
    else
      room.speak "Oops, problem."
    end
  end

  # ===========
  # = /status =
  # ===========
  if message[:body] == "/status"
    users = User.all
    ret = "This is what I know:\r\n"
    users.each do |user|
      ret << "#{user.name} is currently #{user.status}"
      ret << ": #{user.status_message}" unless user.status_message.blank?
      ret << "\r\n"
    end
    room.paste ret
  end

  # ==========
  # = /chuck =
  # ==========
  if message[:body] == "/chuck"
    joke = Scrubyt::Extractor.define do
      fetch "http://4q.cc/index.php?pid=fact&person=chuck"
      joke_text "//div[@id='factbox']"
    end
    results = joke.to_hash
    room.speak results[0][:joke_text]
  end


  # ====================
  # = /finger Nate T. =
  # ====================
  if message[:body] =~ /^\/finger\s(.+)?/
    if User.exists?(:name => $1)
      user = User.find_by_name($1)
      ret = "User: #{user.name}\r\n"
      ret << "Status: #{user.status}\r\n"
      ret << "Status Message: #{user.status_message}\r\n" unless user.status_message.blank?
      ret << "Message Count: #{user.messages.count}\r\n"
      ret << "Last Message: #{user.messages.last.message}\r\n"
      ret << "Last Active: #{to_pretty(user.updated_at)}\r\n"
      room.paste ret
    else
      room.speak "Sorry, I don't know about #{$1}"
    end
  end

  # ==================
  # = /weather 46845 =
  # ==================
  if message[:body] =~ /^\/weather\s(.+)?/
    zip = $1
    if (zip =~ /^\d{5}([\-]\d{4})?$/)
      client = YahooWeather::Client.new
      begin
        response = client.lookup_location(zip)
        room.speak "#{response.title} #{response.condition.temp} degrees #{response.condition.text}"
      rescue
        room.speak "Yahoo doesn't think this a valid zip"
      end
    else
      room.speak "Sorry, I only know 5 digit zip codes at this point"
    end
  end

  # =====================
  # = General Listeners =
  # =====================
  if Admin.listeners_active             # Controlled with /earmuffs command
    if message[:user][:name] != "GitHub"     # Disallow GitHub bot interference when people commit
      Listener.all.each do |handler|
        if message[:body] =~ Regexp.new(handler[0])
          room.speak handler[1]
        end
      end
    end
  end
end