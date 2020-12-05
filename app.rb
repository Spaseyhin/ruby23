#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

get '/' do
	erb :register
end
get '/visit' do
	erb :visit
end
get '/about' do
	erb :about
end
get '/contacts' do
	erb :contacts
end
post '/contacts' do
	f = File.open './public/contacts.txt', 'a'
	@email = params[:email]
	@sms = params[:sms]
	f.write "Email: #{@email}\n Message:#{@sms}\n\n"
	erb :cont
end 
get '/visit' do

	erb :visit
end

post '/visit' do
	
	@username = params[:username]
	@date = params[:date]
	@phone = params[:phone]
	@pric = params[:pric]
	hh = {:username => 'Enter you\'r name',
		  :date => 'Enter you\'r date',
		  :phone => 'Enter you\'r number phone'}
	hh.each do |key, value|
		if params[key] == ''
			@error = hh[key]
			return erb :visit
		end
	end
		
	f = File.open './public/user.txt', 'a'
	f.write "user: #{@username}\n phone:#{@phone}\n dite & time #{@date}\n 
the hairdresser #{@pric}\n\n"
	erb :welcome
end

get '/User' do
	send_file 'public/user.txt'
	erb :User
end