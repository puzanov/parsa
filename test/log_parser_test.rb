require "config"
require "test/unit"
require "lib/log_parser"

class LogParserTest < Test::Unit::TestCase
  def test_parse
    log_datas = Array.new
    log_parser = LogParser.new
    result = File.readlines('test/log_to_parse.log').collect do |line|
      log_datas << log_parser.parse(line)
    end  
    assert_equal("2011-02-10", log_datas[0].date.to_s)
    assert_equal(1731600, log_datas[0].file_id)
    assert_equal(19727, log_datas[0].bytes)
    assert_equal(nil, log_datas[1])
  end
end 
