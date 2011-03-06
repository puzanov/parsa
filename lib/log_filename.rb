class LogFilename
  def self.yesterday
    date = 1.day.ago.to_date.to_s.split("-")
    "access-#{date[0]}_#{date[1]}_#{date[2]}.log"
  end
  def self.today
    date = DateTime.now.to_date.to_s.split("-")
    "access-#{date[0]}_#{date[1]}_#{date[2]}.log"
  end
  def self.past date
    unless /\d{4}_\d{2}_\d{2}/.match(date)
      raise WrongDateFormat
    end
    "access-#{date}.log"
  end
  def self.get_by_argv
    log_filename = LogFilename.send ARGV[0]          if ARGV.length == 1 
    log_filename = LogFilename.send ARGV[0], ARGV[1] if ARGV.length == 2 
    LOG.info "log_filename is #{log_filename}"
    return log_filename
  end
end

class WrongDateFormat < StandardError
end
