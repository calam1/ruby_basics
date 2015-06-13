# app.ru  - run using rackup
require 'sinatra'

class HelloWorldApp < Sinatra::Base

  get '/' do
    "Hello default"
  end

  get '/:name' do
    "Hello #{params[:name]}"
  end

  # get '/?:name?' do
  #   "Hello, #{params[:name] ? params[:name] : "world"}!"
  # end

end
