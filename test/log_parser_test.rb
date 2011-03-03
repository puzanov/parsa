require "config"
require "test/unit"

class LogParserTest < Test::Unit::TestCase
  def test_parse
    format = '%h %v %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %p'
    parser = ApacheLogRegex.new(format)
    result = File.readlines('test/data/from_sftp_access.log').collect do |line|
      line.gsub!("  ", " ")
      parsed_line = parser.parse(line)
      puts parsed_line.inspect
    end  
  end
end



