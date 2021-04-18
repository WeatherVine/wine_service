require 'sinatra'
require 'faraday'
require 'json'
require './services/wine'
require './facades/wine_facade'
require './serializers/wine_serializer'
require './serializers/w_serializer'
require 'pry'
require 'sinatra/json'

  get '/wine-data' do
    wines = WineFacade.wine_objects(params[:location], params[:vintage])

    body WinesSerializer.new(wines).serialized_json
    status 200
  end

  get '/wine-single' do
    wine = WineFacade.wine_single(params[:id])

    require "pry"; binding.pry

    body WSerializer.new(wine).serialized_json
    status 200
  end
