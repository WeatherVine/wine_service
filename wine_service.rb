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

    if params.empty?
      json ({:error => 'Please provide a location and vintage year'})
    elsif params[:location].nil?
      json ({:error => 'Please provide a location'})
    elsif params[:vintage].nil?
      json ({:error => 'Please provide a vintage year'})
    elsif !params[:vintage].to_i.between?(1970,2021)
      json ({:error => 'Please provide a vintage year between 1970 and 2020'})
    else
      wines = WineFacade.wine_objects(params[:location], params[:vintage])

      body WinesSerializer.new(wines).serialized_json
      status 200
    end
  end

  get '/wine-single' do

    if params.empty?
      json ({:error => 'Please provide an id'})
    else
      wine = WineFacade.wine_single(params[:id])

      if wine != "Not Found"
        body WSerializer.new(wine).serialized_json
        status 200
      else
        json ({:error => 'Not Found'})
      end
    end
  end
