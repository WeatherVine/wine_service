# ENV['APP_ENV'] = 'test'

require './wine_service'
require 'rspec'
require 'rack/test'
require 'pry'
require 'spec_helper'

describe 'Wine API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  xit "obtains a collection of wine objects" do
    VCR.use_cassette('collection_wine') do
      get '/wine-data?location=napa valley&vintage=2008'
      expect(last_response).to be_ok

      wines = JSON.parse(last_response.body, symbolize_names: true)

      expect(wines).to be_a(Hash)
      expect(wines[:data].length).to eq(5)
      first = wines[:data][0]
      expect(first[:attributes]).to have_key(:api_id)
      expect(first[:attributes][:api_id]).to be_a(String)
      expect(first[:attributes]).to have_key(:id)
      expect(first[:attributes][:api_id]).to be_a(String)
      expect(first[:attributes]).to have_key(:name)
      expect(first[:attributes][:name]).to be_a(String)
      expect(first[:attributes]).to have_key(:area)
      expect(first[:attributes][:area]).to be_a(String)
      expect(first[:attributes]).to have_key(:vintage)
      expect(first[:attributes][:vintage]).to be_a(String)
    end
  end

  it "obtains a single wine" do
    get '/wine-single?id=5a7a782f43780f1b2595a471'

    expect(last_response).to be_ok

    wine = JSON.parse(last_response.body, symbolize_names: true

    expect(wine).to be_a(Hash)
    expect(wine[:data].length).to eq(3)
    expect(wine[:data][:attributes]).to have_key(:api_id)
    expect(wine[:data][:attributes][:api_id]).to be_a(String)
    expect(wine[:data][:attributes]).to have_key(:id)
    expect(wine[:data][:attributes][:api_id]).to be_a(String)
    expect(wine[:data][:attributes]).to have_key(:name)
    expect(wine[:data][:attributes][:name]).to be_a(String)
    expect(wine[:data][:attributes]).to have_key(:area)
    expect(wine[:data][:attributes][:area]).to be_a(String)
    expect(wine[:data][:attributes]).to have_key(:vintage)
    expect(wine[:data][:attributes][:vintage]).to be_a(String)
    expect(wine[:data][:attributes]).to have_key(:eye)
    expect(wine[:data][:attributes][:vintage]).to be_a(String)
    expect(wine[:data][:attributes]).to have_key(:nose)
    expect(wine[:data][:attributes][:vintage]).to be_a(String)
    expect(wine[:data][:attributes]).to have_key(:mouth)
    expect(wine[:data][:attributes][:vintage]).to be_a(String)
    expect(wine[:data][:attributes]).to have_key(:finish)
    expect(wine[:data][:attributes][:vintage]).to be_a(String)
    expect(wine[:data][:attributes]).to have_key(:overall)
    expect(wine[:data][:attributes][:vintage]).to be_a(String)
  end
end
