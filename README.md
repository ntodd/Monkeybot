Monkeybot
===

Monkeybot is a campfire bot to handle status tracking and misc tasks for the Fort Wayne Screaming Monkey's Guild.

Install
---

Add gems used by Monkeybot (in addition to Rubygems / Rails)

    sudo gem install scrubyt  
    sudo gem install tinder
    sudo gem install firewatir

Create log dir

    mkdir log
  
Run migrations

    rake migrate

Copy database example file for your use

    cp config/database.example.yml config/database.yml

Configure your databases in database.yml

    development:
      adapter: sqlite3
      database: db/development.sqlite3
      pool: 5
      timeout: 5000
    ....

Copy login details file for your use

    copy config/private_details.example.yml to config/private_details.rb

Add your info to private_details.yml

    ACCOUNT  = "subdomain"
    LOGIN    = "email"
    PASSWORD = "password"
    ROOM     = "room name"

Start the bot

    ruby bot.rb

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
  
Slap a user (or anything)

    /slap foo