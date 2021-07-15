require 'rails_helper'

describe APIServices do
  describe "#get_search_movie" do
    xit 'displays data for top 40 rated movies' do
      response_body_1 = File.read('spec/fixtures/top_rated_pg1.json')
      response_body_2 = File.read('spec/fixtures/top_rated_pg2.json')

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['api_key']}&language=en-US&page=1").
      to_return(status: 200, body: response_body_1, headers: {})

      stub_request(:get, "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['api_key']}&language=en-US&page=2").
      to_return(status: 200, body: response_body_2, headers: {})
      # top_rated_stub

      response = APIServices.top_rated_query

      expect(response_1).to be_an(Array)
      expect(response_1).to be_a(Hash)
    end
  end
end
