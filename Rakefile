require "config"

ActiveRecord::Base.logger = LOG

namespace :db do
  desc "Migrate the database"
  task :migrate do
    ActiveRecord::Migrator.migrate('lib/db/migrations', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
  task :rollback do
    ActiveRecord::Migrator.rollback('lib/db/migrations', ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end
end
