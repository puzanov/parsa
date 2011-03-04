require "config"
require "test/unit"
require "lib/utils"

class FileLinesCounterTest < Test::Unit::TestCase
  def test_count
    lines_number = CountLines.of "test/lines.txt"
    assert_equal(3, lines_number)
  end
end
