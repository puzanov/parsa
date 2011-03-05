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
end

class WrongDateFormat < StandardError
end
