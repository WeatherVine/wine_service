require 'json'
require 'ostruct'
require './services/wine'
require './poros/wine.rb'

class WineFacade

  def self.format_location(location)
    location.gsub(/ /, '%20')
  end

  def self.wine_objects(location, vintage)
    formatted_location = format_location(location)
    # require "pry"; binding.pry
    wines = WineService.collection_wines(formatted_location, vintage).map do |wine|
      Wine.new(wine)
    end
  end
end






# def assign_id
#   @assignment_id
# end

# def self.wine_objects
#   wines = WineService.collection_wines.reduce([]) do |acc, wine|
#     acc << OpenStruct.new({
#                             api_id: wine[:id],
#                             name: wine[:Name],
#                             area: wine[:Area],
#                             vintage: wine[:vintage]
#                           })
#   end
# end
