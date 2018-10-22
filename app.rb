require 'rubygems'
require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' #if development?
require 'sinatra/activerecord'
require 'pony'
require 'sqlite3'

set :database, "sqlite3:barbershop.db"

class Client < ActiveRecord::Base
end

get '/' do
  erb :main
end
