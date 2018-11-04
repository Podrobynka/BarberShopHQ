require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' # if development?
require 'sinatra/activerecord'

set :database, 'sqlite3:barbershop.db'

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
  @barbers = Barber.all
end

get '/' do
  @barbers = Barber.order 'created_at DESC'
  erb :index
end

get '/visit' do
  erb :visit
end

post '/visit' do
  @username = params[:username]
  @phone = params[:phone]
  @datetime = params[:datetime]
  barber = params[:barber]
  color = params[:colorpicker]

  Client.create(
    name: @username,
    phone: @phone,
    datestamp: @datetime,
    barber: barber,
    color: color
  )

  @title = 'Thank you!'
  @message = "Dear #{@username}, we'll waiting for you at #{@datetime}."
  erb :visit
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @name = params[:name]
  mail = params[:mail]
  body = params[:body]

  Contact.create(
    name: @name,
    email: mail,
    message: body
  )
  erb :contacts
end
