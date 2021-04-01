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
	@c = Client.new 
	erb :visit
end

post '/visit' do
	@c = Client.new params[:client]
	if @c.save
		erb "<h2>Спасибо за сапись!</h2>"
	else
		@error = @c.errors.full_messages.first
		erb :visit
	end
end

get '/contact' do
	erb :contact
end

post '/contact' do 
	c = Contact.new params[:contact]
	c.save
	erb "Спасибо за сообщение!"
end