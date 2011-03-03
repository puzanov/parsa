require "config"
require "test/unit"

class LogDataManagerTest < Test::Unit::TestCase
  def test_manager
    ActiveRecord::Base.establish_connection(
      :adapter  => 'sqlite3',
      :database => 'data/stat.db')
  end
end
