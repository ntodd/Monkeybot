#!/usr/bin/env ruby

# This is my_app_control.rb. It allows you to daemonize my_app.rb
#
# Usage: ruby my_app_control.rb [start|stop|restart]
#

require 'rubygems'
require 'daemons'

Daemons.run('bot.rb')