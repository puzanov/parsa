class LogFilename
  def self.minus1day
    date = 1.day.ago.to_date.to_s.split("-")
    "access-#{date[0]}_#{date[1]}_#{date[2]}.log"
  end
  def self.current
    date = DateTime.now.to_date.to_s.split("-")
    "access-#{date[0]}_#{date[1]}_#{date[2]}.log"
  end
  def self.past date
    "access-#{date}.log"
  end
end
