require 'sinatra'
require 'faraday'
require 'json'
require './services/wine'
require './facades/wine_facade'
require './serializers/wine_serializer'
require 'pry'
require 'sinatra/json'

  get '/wine-data' do
    wines = WineFacade.wine_objects(params[:location], params[:vintage])

    body WinesSerializer.new(wines).serialized_json
    status 200
  end
