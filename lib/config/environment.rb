require 'rubygems'
require 'active_record'
require 'sqlite3'

$db = SQLite3::Database.new("lib/db/development.sqlite3")
ActiveRecord::Base.logger = Logger.new(STDERR) # Simple logging utility. logger.rb -- standart lib
ActiveRecord::Base.establish_connection(adapter: 'sqlite3',database: 'lib/db/development.sqlite3')
