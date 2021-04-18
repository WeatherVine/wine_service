require 'json'
require 'ostruct'
require './services/wine'
require './poros/wine.rb'
require './poros/w.rb'

class WineFacade

  def self.format_location(location)
    location.gsub(/ /, '%20')
  end

  def self.wine_objects(location, vintage)
    formatted_location = format_location(location)
    wines = WineService.collection_wines(formatted_location, vintage).map do |wine|
      Wine.new(wine)
    end
  end

  def self.wine_single(id)
    wine = WineService.wine_single(id)
    w = W.new(wine)
  end
end
