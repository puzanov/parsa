require "logger"
require "yaml"
require "rubygems"
require "bundler/setup"
Bundler.require(:default)
CONFIG = YAML.load_file("config.yml")
LOG = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
  :adapter  => 'mysql2',
  :host => 'localhost',
  :database => 'parsa',
  :username => 'root',
  :password => 'root'
)

