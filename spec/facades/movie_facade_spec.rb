require 'rails_helper'

RSpec.describe 'MovieFacade' do
  it 'returns array of Film objects for top 40 rated movie search' do
    VCR.use_cassette('top_rated_movies') do

      top_rated_search = MoviesFacade.top_rated

      expect(top_rated_search).to be_an(Array)
      expect(top_rated_search.first).to be_a(Film)
    end
  end

  it 'returns an array of Film objects for title search' do
    search_by_movie_title_stub #in spec_helper
    movie_title_search = MoviesFacade.search_by_movie_title('Hamilton')

    expect(movie_title_search).to be_an(Array)
    expect(movie_title_search.first).to be_a(Film)
  end
end
