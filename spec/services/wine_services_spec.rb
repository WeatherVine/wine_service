require './helpers/test_helper'

describe 'Wine Service API' do
  include Rack::Test::Methods

  def app
    WineServiceApp
  end

  describe 'class methods' do
    it "::conn" do
      connection = WineService.conn

      expect(connection).to be_a(Faraday::Connection)
    end

    it "::location_and_vintage" do
      VCR.use_cassette('collection_wine') do
        result = WineService.collection_wines("napa%20valley", "2008")

        expect(result).to be_an(Array)
        expect(result[0]).to be_a(Hash)
        expect(result[0]).to have_key(:_id)
        expect(result[0]).to have_key(:id)
        expect(result[0]).to have_key(:Name)
        expect(result[0]).to have_key(:Winery)
        expect(result[0]).to have_key(:Area)
        expect(result[0]).to have_key(:Province)
        expect(result[0]).to have_key(:Country)
        expect(result[0]).to have_key(:Varietal)
        expect(result[0]).to have_key(:vintage)
        expect(result[0]).to have_key(:Style)
        expect(result[0]).to have_key(:Type)
        expect(result.length).to eq(5)
      end
    end

    it '::wine_single can return a single wine' do
      VCR.use_cassette('single_wine') do
        result = WineService.wine_single('5a7a782f43780f1b2595a471')

        expect(result).to be_an(Hash)
        expect(result).to have_key(:aggregate)
        expect(result[:aggregate]).to have_key(:scoreAvg)
        expect(result[:aggregate]).to have_key(:wine)
        expect(result[:aggregate][:wine]).to have_key(:id)
        expect(result[:aggregate][:wine]).to have_key(:Name)
        expect(result[:aggregate][:wine]).to have_key(:Winery)
        expect(result[:aggregate][:wine]).to have_key(:vintage)
        expect(result[:aggregate][:wine]).to have_key(:Country)
        expect(result[:aggregate][:wine]).to have_key(:Province)
        expect(result[:aggregate][:wine]).to have_key(:Area)
        expect(result[:aggregate][:wine]).to have_key(:Style)
        expect(result[:aggregate][:wine]).to have_key(:Tags)
        expect(result[:aggregate][:wine]).to have_key(:Varietal)
        expect(result[:aggregate][:wine]).to have_key(:Type)
        expect(result[:aggregate]).to have_key(:count)
      end
    end

    it "::wine_single will return an error if no wine is found" do
      VCR.use_cassette('no_data') do
        result = WineService.wine_single('0')

        expect(result).to eq('Not Found')
      end
    end
  end
end
