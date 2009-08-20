Monkeybot
===

Monkeybot is a campfire bot to handle status tracking and misc tasks for the Fort Wayne Screaming Monkey's Guild.

Install
---

Create log dir

    mkdir log
  
Run migrations

    rake migrate
  
Create login details

    touch config/private_details.rb
  
Add your info

    ACCOUNT = "xxx"
    LOGIN = "xxx"
    PASSWORD = "xxx"
    ROOM = "xxx"

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