class LogDataManager2
  require "mysql"

  attr_accessor :db, :statement

  def initialize
    @db = Mysql.new('localhost', 'parsa', 'parsa', 'parsa')
    rescue Mysql::Error
      LOG.error "Could not connect to database #{@db::errstr}"
    @statement = db.prepare "INSERT INTO log_data (file_id,bytes,date) (?,?,?) on duplicate key update bytes = bytes + ?"
  end

  def save array 
    @statement.execute (array[0],array[1],array[2],array[1])
  end
end

