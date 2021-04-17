ENV['APP_ENV'] = 'test'

require './wine_service'
require 'rspec'
require 'rack/test'
require 'pry'

describe 'Wine API' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "obtains a collection of wine objects" do
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
