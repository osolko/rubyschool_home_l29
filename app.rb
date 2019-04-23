#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class  Client < ActiveRecord::Base
end

class  Barber < ActiveRecord::Base
end


# insert new value to table with ActiveRecord
# Barber.create :name => 'Mike Jonson'

get '/' do
	@barbers = Barber.all
	erb :index
end