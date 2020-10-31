require 'sinatra'
require 'sinatra/reloader' if development?
require 'pg'
require 'bcrypt'
require_relative 'data_access.rb'

enable :sessions

def logged_in?()
  if session[:user_id]
    true
  else
    false
  end
end

def current_user()
  find_user_by_name(session[:user_id])
end


get '/' do
  erb :login
end

get '/landingpage' do
  result = all_items()
  erb :landingpage, locals: {
    result: result,
  }
end

get '/landingpage' do
  result = all_items()

  erb :landingpage, locals: {
    result: result
  }
end

get '/create' do
  erb :create
end

post '/create' do
  create_item(params['name'],params['quantity'], params['destination'], params['notes'])
redirect "/landingpage"
end

get '/update' do
  result = all_items()
  erb :update, locals: {
    result: result
  }
end

post '/update' do
  update_item(params['name'], params['quantity'], params['destination'], params['notes'])
  redirect "landingpage"
end

post '/delete' do
  delete_item(params['name'])
  redirect "/landingpage"
end

get '/delete' do
  result = all_items()
  erb :delete, locals: {
    result: result
  }
end

get '/login' do
  erb :login
end

post '/login' do
  user = find_user_by_name(params['name'])
  if BCrypt::Password.new(user['password_digest']) == params['password']
    session[:user_id] = user['id']
    redirect "/landingpage"
  else
    redirect "/session"
  end
end


get '/signup' do
  erb :signup
end

post '/signup' do
  create_customer(params['name'], params['password_digest'])
  redirect "/login"
end

get '/customerlogin' do
erb :login
end


post '/customerlogin' do
  user = find_customer_by_name(params['name'])
  if BCrypt::Password.new(user['password_digest']) != params['password']
    session[:user_id] = user['id']
    redirect "/customerlandingpage/#{params['name']}"
   else
     redirect "/session"
  end
end

get '/customerlandingpage/:name' do 
  result = all_items()
  customer=params['name']
  customer_data=display_customer_items(customer)
erb :customerlandingpage, locals: {
  customer: customer,
  customer_data: customer_data
}
end

get '/session' do
  session[:user_id] = nil
  redirect '/login'
end




















