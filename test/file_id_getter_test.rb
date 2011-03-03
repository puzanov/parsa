require "config"
require "test/unit"

class FileIdGetterTest < Test::Unit::TestCase
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

