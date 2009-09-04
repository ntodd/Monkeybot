require 'rubygems'
require 'tinder'
require 'scrubyt'
require 'activerecord'
require 'config/private_details'
require 'config/environment'
require 'firewatir'

# Find environment
# This is rather hacky since it isn't needed by tinder, but by the rake tasks.  Probably could strip it.
RACK_ENV = ENV['RACK_ENV'] || 'development' unless defined? RACK_ENV

MESSAGE_EXCEPTIONS = [ "Monkeybot", "Toddbot", "Ad", "" ]

# Load db config and establish connection
ActiveRecord::Base.establish_connection YAML.load(File.read(File.join(File.dirname(__FILE__), 'config', 'database.yml'))).with_indifferent_access[RACK_ENV]

# Setup logger for activerecord
ActiveRecord::Base.logger = Logger.new(File.open(File.join(File.dirname(__FILE__), 'log', "#{RACK_ENV}.log"), 'a'))

# Load libs from lib/
Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each {|lib| require lib }

# Load helpers from helpers/
Dir[File.join(File.dirname(__FILE__), 'helpers', '*.rb')].each {|lib| require lib }