require 'sinatra'
require 'pony'
require 'pry'

get '/' do
  erb :index
end

post '/contact' do
  @notification = "Something happened!"
  binding.pry
  redirect '/'
end
