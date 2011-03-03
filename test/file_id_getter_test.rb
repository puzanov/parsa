require "config"
require "test/unit"
require "lib/file_id_getter"

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
  
  def test_get_file_id_3
    request = "GET /files/1289123/news.jpg HTTP/1.0"
    file_id = FileIdGetter.get_from request
    assert_equal("1289123", file_id)
  end
  
  def test_get_file_id_4
    request = "GET /files/1289124/ HTTP/1.0"
    file_id = FileIdGetter.get_from request
    assert_equal("1289124", file_id)
  end
  
  def test_get_file_id_5
    request = "GET /files/1729415/%d0%91%d0%b0%d1%81%d1%82%d0%b0%20%d0%b8%20%d0%a1%d0%bb%d0%be%d0%b2%d0%b5%d1%82%d1%81%d0%ba%d0%b8%d0%b9%20(%d0%9a%d0%be%d0%bd%d1%81%d1%82%d0%b0%d0%bd%d1%82%d0%b0)%20-%20%d0%9f%d0%be%d0%b9%d0%b4%d0%b5%d0%bc%20%d0%bf%d0%be%d0%ba%d1%83%d1%80%d0%b8%d0%bc%20%d0%bd%d0%b0%20%d0%bb%d0%be%d0%b4%d0%b6%d0%b8%d1%8e.mp3 HTTP/1.1"
    file_id = FileIdGetter.get_from request
    assert_equal("1729415", file_id)
  end
  
  def test_get_file_id_6
    request = "GET /files/9ccdf9463c0e7c18b7c0f966d76dbdfa/4d53c377/1732662/video.flv HTTP/1.1"
    file_id = FileIdGetter.get_from request
    assert_equal("1732662", file_id)
  end
  
  def test_get_file_id_7
    request = "GET /files/9ccdf9463c0e7c18b7c0f966d76dbdfa/4d53c377/1732663/ HTTP/1.1"
    file_id = FileIdGetter.get_from request
    assert_equal("1732663", file_id)
  end
  
  def test_get_file_id_8
    request = "GET /files/9ccdf9463c0e7c18b7c0f966d76dbdfa/4d53c377/1732664 HTTP/1.1"
    file_id = FileIdGetter.get_from request
    assert_equal("1732664", file_id)
  end
end
