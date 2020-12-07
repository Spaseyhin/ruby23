#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'

def get_db
	return SQLite3::Database.new 'barbershop.db'
end

configure do
	db = get_db
	db.execute 'CREATE TABLE IF NOT EXISTS 
	"users" 
	(
	"id" INTEGER PRIMARY KEY AUTOINCREMENT,
	 "username" TEXT,
	 "phone" TEXT,
	 "date" TEXT,
	 "pric" TEXT
	 )'

end


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
	@phone = params[:phone]
	@date = params[:date]
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

# 	f = File.open './public/user.txt', 'a'
# 	f.write "user: #{@username}\n phone:#{@phone}\n dite & time #{@date}\n
# the hairdresser #{@pric}\n\n" 


db = get_db
db.execute 'insert into
	Users 
	(
	username,
	phone, 
	date,
	pric
	)
	values (?,?,?,?)', [@username, @phone, @date, @pric]
	erb :welcome
end

get '/User' do
	send_file 'public/user.txt'
	erb :User
end
