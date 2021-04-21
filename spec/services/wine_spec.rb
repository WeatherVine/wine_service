# ENV['APP_ENV'] = 'test'
require './helpers/test_helper'

describe 'Wine API' do
  include Rack::Test::Methods

  def app
    WineServiceApp
    # Sinatra::Application
  end

  it 'obtains a collection of wine objects' do
    VCR.use_cassette('collection_wine') do
      get '/wine-data?location=napa%20valley&vintage=2008'

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

  it 'collection wine returns an error if location and vintage query params are missing' do
    get '/wine-data'

    expect(last_response).to be_ok

    error = JSON.parse(last_response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to be_a(String)
    expect(error[:error]).to eq('Please provide a location and vintage year')
  end

  it 'collection wine returns an error more than location and vintage query params are passed in the search' do
    get '/wine-data?location=napa valley&vintage=2008&foo=bar'

    expect(last_response).to be_ok

    error = JSON.parse(last_response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to be_a(String)
    expect(error[:error]).to eq('Please provide only a location and vintage year')
  end

  it 'collection wine returns an errror if location query params is missing' do
    get '/wine-data?vintage=2008'

    expect(last_response).to be_ok

    error = JSON.parse(last_response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to be_a(String)
    expect(error[:error]).to eq('Please provide a location')
  end

  it 'collection wine returns an errror if vintage year query params is missing' do
    get '/wine-data?location=napa valley'

    expect(last_response).to be_ok

    error = JSON.parse(last_response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to be_a(String)
    expect(error[:error]).to eq('Please provide a vintage year')
  end

  it 'collection wine returns an errror if vintage year query params is before 1970' do
    get '/wine-data?location=napa valley&vintage=1969'

    expect(last_response).to be_ok

    error = JSON.parse(last_response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to be_a(String)
    expect(error[:error]).to eq('Please provide a vintage year between 1970 and 2020')
  end

  it 'collection wine returns an errror if vintage year query params is after 2021' do
    get '/wine-data?location=napa valley&vintage=2022'

    expect(last_response).to be_ok

    error = JSON.parse(last_response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to be_a(String)
    expect(error[:error]).to eq('Please provide a vintage year between 1970 and 2020')
  end

  it 'obtains a single wine' do
    VCR.use_cassette('single_wine') do
      get '/wine-single?id=5a7a782f43780f1b2595a471'

      expect(last_response).to be_ok

      wine = JSON.parse(last_response.body, symbolize_names: true)

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

  it 'single wine returns an error if the id query param is missing' do
    get '/wine-single'

    expect(last_response).to be_ok

    error = JSON.parse(last_response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to be_a(String)
    expect(error[:error]).to eq('Please provide an id')
  end

  it 'single wine returns an error if the id does not return data' do
    VCR.use_cassette('no_data') do
      get '/wine-single?id=0'

      expect(last_response).to be_ok

      error = JSON.parse(last_response.body, symbolize_names: true)

      expect(error).to be_a(Hash)
      expect(error[:error]).to be_a(String)
      expect(error[:error]).to eq('Not Found')
    end
  end

  it 'single wine returns an error when more than id query params is passed in the search' do
    get '/wine-single?id=5a7a782f43780f1b2595a471&foo=bar'

    expect(last_response).to be_ok

    error = JSON.parse(last_response.body, symbolize_names: true)

    expect(error).to be_a(Hash)
    expect(error[:error]).to be_a(String)
    expect(error[:error]).to eq('Please provide only an id')
  end
end
