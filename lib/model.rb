require 'rubygems'
require 'active_record'
require 'sqlite3'

#require 'lib/config/environment.rb'
ActiveRecord::Base.establish_connection(adapter: 'sqlite3',database: 'lib/db/development.sqlite3')

class Group < ActiveRecord::Base


end
class Individual< ActiveRecord::Base

end

