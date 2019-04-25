#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class  Client < ActiveRecord::Base
#validates inherit method from ActiveRecord
  validates :name, presence: true
  validates :phone, presence: true
  validates :datestamp, presence: true
  validates :barber, presence: true

end

class  Barber < ActiveRecord::Base
end

class  Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

# insert new value to table with ActiveRecord
# Barber.create :name => 'Mike Jonson'

get '/' do
	# @barbers = Barber.all
	# make  with order
	  @barbers = Barber.order 'created_at DESC'

	erb :index
end


get '/visit' do
	erb :visit
end

post '/visit' do

	c = Client.new params[:client]	
	if c.save 
 		erb "<h2>Thank you, we will contact with you!</h2>"
 	else
 		@error = c.errors.full_messages.first
 		erb :visit
 	end
end



get '/contacts' do
	erb :contacts
end


post '/contacts' do
	@email	  = params[:email]
	@message  = params[:message]

Contact.create :email =>@email , :message => @message

 	erb "<h3>Thank you for your message.. see you</h3>"


end
