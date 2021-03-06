require_relative 'config/environment'
require 'json'
require 'rest_client'
require 'pry'

class App < Sinatra::Base
  get '/' do
    @error = params['error']
    erb :home
  end
  
  get '/home' do
    @error = params['error']
    erb :home
  end
  
  get '/team' do
    @error = params['error']
    erb :team
  end

  get '/VFAsplash' do
    @error = params['error']
    erb :VFAsplash
  end

  get '/youtube' do
    @error = params['error']
    erb :youtube
  end

  get '/rainbow' do
    @error = params['error']
    erb :rainbow
  end

  post '/subscribe' do
    @full_name = params[:full_name]
    @email = params[:email]
    @location = params[:location]

    if !@email.match(/.+@.+/)
      redirect to('/?error=email')
    end

    erb :subscribe
  end

  get '/reddit' do
    # TODO: we can probably get the listings with something like:
    # JSON.parse(RestClient.get('http://reddit.com/.json'))
    stuff = JSON.parse(RestClient.get('http://reddit.com/.json'))
    children = stuff["data"]["children"]
    final = []
    children.each do |thing|
        final.push(thing["data"]["title"])
    end
    
    @listings=final

    erb :reddit
  end

  get '/schedule' do
    @today = [
      ['7:00am', 'Wake up'],
      ['8:00am', 'Work Out'],
      ['9:00am', 'Product Meeting'],
      ['11:00am', 'Ping Pong Break'],
      ['1:00pm', 'Lunch'],
      ['3:00pm', 'Coffee Time'],
      ['6:30pm', 'Call it a day'],
    ]

    @tomorrow = [
      ['7:00am', 'Wake up'],
      ['8:00am', 'Work Out'],
      ['9:00am', 'Inbox Zero'],
      ['11:00am', 'Ping Pong Break'],
      ['1:00pm', 'Lunch'],
      ['3:00pm', 'Coffee Time'],
      ['6:30pm', 'Meetup Presentation'],
    ]

    erb :schedule
  
end

end
