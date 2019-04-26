#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, "sqlite3:barbershop.db"

class  Client < ActiveRecord::Base
#validates inherit method from ActiveRecord
  validates :name, presence: true, length: { minimum:3, maximum:5 }
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

get '/' do
	# @barbers = Barber.all
	# make  with order
	  @barbers = Barber.order 'created_at DESC'

	erb :index
end


get '/visit' do
	@c = Client.new
	erb :visit
end

post '/visit' do

	@c = Client.new params[:client]	
	if @c.save 
 		erb "<h2>Thank you, we will contact with you!</h2>"
 	else
 		@error = @c.errors.full_messages.first
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


get '/barber/:id' do
 @barber = Barber.find(params[:id])
 erb :barber
end

get '/visitor' do
 @client = Client.order('created_at DESC')

 erb :booking

end


get '/visitor/:id' do
 @client = Client.find(params[:id])

 erb :client

end



