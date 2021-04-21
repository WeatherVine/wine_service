require 'faraday'
require 'json'
require 'figaro/sinatra'

class WineService
  @@page = 0
  @@collection_wines = []

  def self.increase_page
    @@page += 10
  end

  def self.conn
    conn = Faraday.new(
      url: 'https://quiniwine.com',
      headers: { 'Authorization': "Bearer #{ENV['WINE_KEY']}" }
    )
  end

  def self.location_and_vintage(location, vintage)
    response = conn.get("/api/pub/wineKeywordSearch/#{vintage}%20#{location}/#{@@page}")
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

  def self.wine_single(id)
    # '/api/pub/wineSummary.json?wine_id=5f065fb5fbfd6e17acaad294'
    response = conn.get('/api/pub/wineSummary.json') do |req|
      req.params['wine_id'] = id
    end

    if response.body == 'Not Found'
      'Not Found'
    else
      search = JSON.parse(response.body, symbolize_names: true)
    end
  end
end
