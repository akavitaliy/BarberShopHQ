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
	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@colors = params[:colors]

	Client.create(:name => params[:username], :phone => params[:phone], :datestamp => params[:datetime], :barber => params[:barber], :color => params[:colors]) 
	erb "Спасибо за сапись!"

end