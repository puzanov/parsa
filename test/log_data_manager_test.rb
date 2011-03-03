require "config"
require "test/unit"

class LogDataManagerTest < Test::Unit::TestCase
  def test_manager
    ActiveRecord::Base.logger = LOG
    ActiveRecord::Base.establish_connection(
      :adapter  => 'mysql',
      :host => 'localhost',
      :database => 'parsa',
      :username => 'root',
      :password => 'root'
    )
    puts "ok"
  end
end
