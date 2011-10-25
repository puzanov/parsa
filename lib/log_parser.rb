class LogParser
  require "lib/file_id_getter"
  require "lib/log_data"

  attr_accessor :valid_statuses, :log_format, :apache_log_parser

  def initialize
    log_format = '%h %v %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %p'
    @apache_log_parser = ApacheLogRegex.new(log_format)
    @valid_statuses = ["200", "206", "304", "420"]
  end

  def parse line
    line.gsub!("  ", " ")
    parsed_line = @apache_log_parser.parse(line)
    return nil if parsed_line.nil?
    return nil if @valid_statuses.index(parsed_line["%>s"]).nil?
    file_id = FileIdGetter.get_from parsed_line["%r"]
    unless file_id.nil?
#      log_data = LogData.new
    #  log_data = []
    #  log_data.push( file_id.to_i )
    #  log_data.push ( parsed_line["%b"].to_i )
    #  log_data.push ( parsed_line["%t"] )
      return [file_id.to_i, parsed_line["%b"].to_i, parsed_line["%t"]]
    end
    return nil
  end
end
