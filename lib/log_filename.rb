class LogFilename
  def self.yesterday prefix
    date = 1.day.ago.to_date.to_s.split("-")
    "#{prefix}#{date[0]}_#{date[1]}_#{date[2]}.log"
  end
  def self.today prefix
    date = DateTime.now.to_date.to_s.split("-")
    "#{prefix}#{date[0]}_#{date[1]}_#{date[2]}.log"
  end
  def self.past date, prefix
    unless /\d{4}_\d{2}_\d{2}/.match(date)
      raise WrongDateFormat
    end
    "#{prefix}#{date}.log"
  end
  def self.get_by_argv prefix
    log_filename = LogFilename.send ARGV[0], prefix          if ARGV.length == 1 
    log_filename = LogFilename.send ARGV[0], ARGV[1], prefix if ARGV.length == 2 
    LOG.info "log_filename is #{log_filename}"
    return log_filename
  end
end

class WrongDateFormat < StandardError
end
