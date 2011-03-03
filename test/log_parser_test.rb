require "config"
require "test/unit"

class LogParserTest < Test::Unit::TestCase
  def AAA_test_parse
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

  def test_get_file_id_1
    request = "GET /files/225568 HTTP/1.0"
    file_id = FileIdGetter.get_from request
    assert_equal("225568", file_id)
  end
  
  def test_get_file_id_2
    request = "GET /files/1289122/preview.jpg HTTP/1.0"
    file_id = FileIdGetter.get_from request
    assert_equal("1289122", file_id)
  end
end

class FileIdGetter
  def self.get_from request
    matched = /GET \/files\/(\d*) HTTP/.match(request)
    return matched[1] unless matched.nil?
    return nil
  end
end

