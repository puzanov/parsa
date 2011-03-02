require "logger"
require "yaml"
require "rubygems"
require "bundler/setup"
Bundler.require(:default)
CONFIG = YAML.load_file("config.yml")
LOG = Logger.new(STDOUT)
