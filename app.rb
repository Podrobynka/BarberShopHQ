require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' # if development?
require 'sinatra/activerecord'

set :database, 'sqlite3:barbershop.db'

class Client < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 3 }
  validates :phone, presence: true
  validates :datestamp, presence: true
  validates :color, presence: true
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
  @c = Client.new
  erb :visit
end

post '/visit' do
  @username = params[:name]
  @datetime = params[:datestamp]

  @c = Client.new(params)
  if @c.save
    @title = 'Thank you!'
    @message = "Dear #{@username}, we'll waiting for you at #{@datetime}."
    erb :visit
  else
    @error = @c.errors.full_messages.first
    erb :visit
  end
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

get '/barber/:id' do
  @barber = Barber.find(params[:id])
  erb :barber
end

get '/bookings' do
  @clients = Client.order('created_at DESC')
  erb :bookings
end

get '/client/:id' do
  @client = Client.find(params[:id])
  erb :client
end