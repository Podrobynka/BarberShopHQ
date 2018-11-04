require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' # if development?
require 'sinatra/activerecord'

set :database, 'sqlite3:barbershop.db'

class Client < ActiveRecord::Base
  validates :name, presents: true
  validates :phone, presents: true
  validates :datestamp, presents: true
  validates :color, presents: true
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
  @username = params[:name]
  @datetime = params[:datestamp]

  Client.create(params)

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
