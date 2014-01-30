require_relative 'lib/config/environment'
require 'active_record'
require 'sqlite3'

namespace :db do
  desc "Migrate data"
  task :migrate do

    ActiveRecord::Migrator.migrate('lib/db/migrate',ENV["VERSION"] ? ENV["VERSION"].to_i : nil )
  end

end
