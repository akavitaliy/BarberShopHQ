#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require 'rake'

set :database, {adapter: "sqlite3", database: "barber.db"}

class Client < ActiveRecord::Base
	validates :name, presence: true
	validates :phone, presence: true
	validates :datestamp, presence: true
	validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

before do
	@barbers = Barber.order "created_at DESC"
end

get '/' do
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do
	@c = Client.new params[:client]
	@c.save
	erb "Спасибо за сапись!"
end

get '/contact' do
	erb :contact
end

post '/contact' do 
	c = Contact.new params[:contact]
	c.save
	erb "Спасибо за сообщение!"
end