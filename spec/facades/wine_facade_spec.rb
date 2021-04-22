require './helpers/test_helper'

describe 'Wine Facade API' do
  include Rack::Test::Methods

  def app
    WineServiceApp
  end

  describe 'class methods happy path' do
    it '::format_location' do
      location = 'napa valley'
      formatted_location = WineFacade.format_location(location)

      expect(formatted_location).to eq('napa%20valley')
    end

    it '::wine_objects' do
      VCR.use_cassette('collection_wine') do
        wines = WineFacade.wine_objects('napa%20valley', '2008')

        expect(wines).to be_an(Array)
        expect(wines.length).to eq(5)
        expect(wines[0]).to be_a(Wine)
        expect(wines[0].respond_to?('api_id')).to eq(true)
        expect(wines[0].respond_to?('area')).to eq(true)
        expect(wines[0].respond_to?('id')).to eq(true)
        expect(wines[0].respond_to?('name')).to eq(true)
        expect(wines[0].respond_to?('vintage')).to eq(true)
      end
    end

    it '::wine_single can return a single wine' do
      VCR.use_cassette('single_wine') do
        wine = WineFacade.wine_single('5a7a782f43780f1b2595a471')

        expect(wine).to be_a(W)
        expect(wine.respond_to?('api_id')).to eq(true)
        expect(wine.respond_to?('area')).to eq(true)
        expect(wine.respond_to?('eye')).to eq(true)
        expect(wine.respond_to?('finish')).to eq(true)
        expect(wine.respond_to?('id')).to eq(true)
        expect(wine.respond_to?('mouth')).to eq(true)
        expect(wine.respond_to?('name')).to eq(true)
        expect(wine.respond_to?('nose')).to eq(true)
        expect(wine.respond_to?('overall')).to eq(true)
        expect(wine.respond_to?('vintage')).to eq(true)
      end
    end
  end

  describe 'class methods sad path' do 
    it "::wine_single will return an error if no wine is found" do
      VCR.use_cassette('no_data') do
        result = WineFacade.wine_single('0')

        expect(result).to eq('Not Found')
      end
    end
  end
end
