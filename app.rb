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
	@username = params[:username]
	@phone 	  = params[:phone]
	@datetime = params[:datetime]
	@barber   = params[:barber]
	@color	  = params[:color] 

# 1-st variant to save
# Client.create :name => @username ,  :phone => @phone , :datestamp => @datetime , :barber => @barber , :color => @color

# 2-nd variant to save

	c = Client.new
	c.name 		= @username  
	c.phone 	= @phone 
	c.datestamp = @datetime 
	c.barber 	= @barber  
	c.color 	= @color
	c.save



 	erb "<h2>Thank you <b>#{@username.capitalize}</b>, we will contact with you!</h2>"
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
