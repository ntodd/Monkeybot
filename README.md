Monkeybot
===

Monkeybot is a campfire bot to handle status tracking and misc tasks for the Fort Wayne Screaming Monkey's Guild.

The system is currently an organic hodgepodge and probably shouldn't be used anywhere without some TLC.

Install
---

Add gems used by Monkeybot (in addition to Rubygems / Rails)

    sudo gem install scrubyt tinder firewatir daemons

Create log dir

    mkdir log
  
Run migrations

    rake migrate

Set up your own environment in init.rb
    
    # Use this env for your database config
    RACK_ENV = 'my_env'

Copy database example file for your use

    cp config/database.example.yml config/database.yml

Copy login details file for your use

    copy config/private_details.example.yml to config/private_details.rb

Add your info to config/private_details.rb

    ACCOUNT  = "subdomain"
    LOGIN    = "email"
    PASSWORD = "password"
    ROOM     = "room name"
    
Start the bot

    ruby bot.rb

Start/stop/restart the bot as a daemon (useful for "production" mode)

    ruby bot_runner.rb start
    ruby bot_runner.rb stop
    ruby bot_runner.rb restart

Supported Commands
---

Change room topic

    /topic foo topic
  
Search google (5 results)

    /search foo search query
  
Set yourself away

    /away
    /away foo status message
  
Set yourself back

    /back
    /back foo status message
  
View all user statuses

    /status
  
Set your status message without changing active/away status

    /status foo status message
  
Get details and stats on a specific user

    /finger foo user
  
Tell a random joke

    /joke
  
Random Chuck Norris fact

    /chuck

Random Mr. T fact

    /mrt
  
Slap a user (or anything)

    /slap foo
    
Bitchslap Tim Novinger regardless of target user

    /bitchslap foo

Generate random strings (up to 40 chars)

    /random 8

Get weather report for a zipcode

    /weather 46845

General Listeners
---

Comment whenever someone mentions the word "GEM"
[case-insensitive]

    /speaks the phrase "Oooooh shiny!!!"

Comment whenever someone mentions the word "FORT WAYNE"
[case-insensitive]

    /speaks the phrase "Fort Wayne FTW!"
    
Comment whenever someone mentions the word "MOM"
[case-insensitive]

    /speaks the phrase "Hey now, no reason to drag someone's mom into this."
    
To do list
===

* Email log of day's messages
* Could email some outputs instead of dump to chat
