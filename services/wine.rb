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

  def self.location_and_vintage(location, vintage)
    response = conn.get("/api/pub/wineKeywordSearch/#{vintage}%20n#{location}/#{@@page}")
    search = JSON.parse(response.body, symbolize_names: true)
  end

  def self.wines(location, vintage)
    wines = location_and_vintage(location, vintage)
    wines[:items].each do |wine|
      if @@collection_wines.length == 5
        break
      elsif wine[:vintage].to_i == vintage.to_i
        @@collection_wines << wine
      end
    end
  end


  def self.collection_wines(location, vintage)
    while @@collection_wines.length < 5
      self.wines(location, vintage)
      self.increase_page
    end
    @@collection_wines
  end
end
