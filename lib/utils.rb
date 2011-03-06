class CountLines
  def self.of file
    return %x{wc -l #{file}}.split(" ")[0].to_i
  end
end

class Help
  def self.show_me_if_needed_and_exit
    if ARGV.length == 0
      puts "This is PARSA!"
      puts "Usage:"
      puts "   ruby parsa.rb today"
      puts "      this will parse logs for today"
      puts "   ruby parsa.rb yesterday"
      puts "      this will parse logs for yesterday"
      puts "   ruby parsa.rb past yyyy_mm_dd"
      puts "      this will parse logs for specified day in past"
      Process.exit
    end
  end
end

class LocalLogs
  def self.delete log_path
    LOG.warn "Delete local log file if exists"
    File.delete(log_path) if File.exists?(log_path)
    File.delete(log_path + ".gz") if File.exists?(log_path + ".gz")
  end
end
