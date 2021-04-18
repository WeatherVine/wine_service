require 'faraday'
require 'json'

class WineService
  @@page = 0
  @@collection_wines = []

  def self.increase_page
    @@page += 10
  end

  def self.conn
    conn = Faraday.new(
      url: 'https://quiniwine.com',
      headers: { 'Authorization': 'Bearer ups39uhsv7zc2a9jvkb1' }
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
    search = JSON.parse(response.body, symbolize_names: true)
  end
end

# Altamura = 5a820b7154f765b05c5bd94a
# Celani = 5b1588fcedcff42611e5db3c
# Cameron Hughes = 5205521de817460200000002
# Grgich Hills = 5a7a782f43780f1b2595a471
# Altamura = 5a820b7154f765b05c5bd94a
