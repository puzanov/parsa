class LogFilename
  def self.get
    date = 1.day.ago.to_date.to_s.split("-")
    "access-#{date[0]}_#{date[1]}_#{date[2]}.log"
  end
end
