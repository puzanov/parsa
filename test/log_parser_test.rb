require "config"
require "test/unit"

class LogParserTest < Test::Unit::TestCase
  def test_parse
    valid_statuses = ["200", "206", "304", "420"]
    format = '%h %v %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %p'
    parser = ApacheLogRegex.new(format)
    result = File.readlines('test/data/from_sftp_access.log').collect do |line|
      line.gsub!("  ", " ")
      parsed_line = parser.parse(line)
      unless parsed_line.nil?
        next if parsed_line["%r"] == "GET /progress HTTP/1.1"
        next if valid_statuses.index(parsed_line["%>s"]).nil?
        puts parsed_line["%>s"]
        puts parsed_line["%b"]
        puts parsed_line["%r"]
        

        matched = /GET \/files\/(\d*)\/(.) HTTP/.match(parsed_line["%r"])
        puts matched[1] unless matched.nil?

      end  
    end  
  end
end  
