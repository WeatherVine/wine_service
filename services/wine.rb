require 'faraday'
require 'json'

class WineService
  @@page = 0
  @@collection_wines = []

  def self.increase_page
    @@page += 1
  end

  def self.conn
    conn = Faraday.new(
      'https://quiniwine.com'
    )
  end

  def self.location_and_vintage
    response = conn.get("/api/pub/wineKeywordSearch/2008%20napa%20valley/#{@page}")
    search = JSON.parse(response.body, symbolize_names: true)
  end

  def self.wines
    require "pry"; binding.pry
    self.location_and_vintage[:items].each do |wine|
      require "pry"; binding.pry
      if wine[:vintage].to_i == 2008
        # && @@collection_wines.length < 5
        require "pry"; binding.pry
        @@collection_wines << wine
      else
        break
      end
    end
    require "pry"; binding.pry
  end


  def self.collection_wines
    require "pry"; binding.pry

    while @@collection_wines.length < 5
      require "pry"; binding.pry
      self.wines
      self.increase_page
    end
    @@collection_wines
  end
end
