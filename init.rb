%w( rubygems tinder scrubyt activerecord yahoo-weather sha1 ).each {|lib| require lib }
require File.join(File.dirname(__FILE__), 'config', 'environment' )
require File.join(File.dirname(__FILE__), 'config', 'private_details' )

# Find environment
# This is rather hacky since it isn't needed by tinder, but by the rake tasks and db config.  Probably could strip it.
RACK_ENV = 'production'

MESSAGE_EXCEPTIONS = [ "Monkeybot", "Toddbot", "Ad", "" ]

# Load db config and establish connection
ActiveRecord::Base.establish_connection YAML.load(File.read(File.join(File.dirname(__FILE__), 'config', 'database.yml'))).with_indifferent_access[RACK_ENV]

# Setup logger for activerecord
ActiveRecord::Base.logger = Logger.new(File.open(File.join(File.dirname(__FILE__), 'log', "#{RACK_ENV}.log"), 'a'))

# Load libs from lib/
Dir[File.join(File.dirname(__FILE__), 'lib', '*.rb')].each {|lib| require lib }

# Load helpers from helpers/
Dir[File.join(File.dirname(__FILE__), 'helpers', '*.rb')].each {|lib| require lib }