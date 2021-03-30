#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'rake'

set :database, {adapter: "sqlite3", database: "barber.db"}

class Client < ActiveRecord::Base
end

class Barber < ActiveRecord::Base
end

get '/' do
	@barbers = Barber.all
	erb :index
end