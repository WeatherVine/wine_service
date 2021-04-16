require 'sinatra'
require 'faraday'
require 'json'
require './services/wine'

  get '/' do
    x = WineService.collection_wines
    require "pry"; binding.pry
  end

    # @page = 0

    # def conn
    #   @conn = Faraday.new(
    #     'https://quiniwine.com'
    #   )
    # end
    #
    # def location_and_vintage
    #   response = conn.get("/api/pub/wineKeywordSearch/napa%20napa%20valley/#{@page}")
    #   search = JSON.parse(response.body, symbolize_names: true)
    # end


  #
  #
  # def increase_page
  #   @page += 1
  # end
