require 'rails_helper'

RSpec.describe 'New viewing party page' do
  before :each do
    @user_1 = User.create!(email: 'roald@gmail.com', password: 'test')
    @user_2 = User.create!(email: 'empanada_luvr@email.com', password: 'hocuspocus')
    @user_3 = User.create!(email: 'cheese_luvr@email.com', password: 'password')
    @user_4 = User.create!(email: 'cat_luvr@email.com', password: 'catz')

    @friendship_1 = UserFriendship.create(user_id: @user_1.id, friend_id: @user_2.id)
    @friendship_2 = UserFriendship.create(user_id: @user_1.id, friend_id: @user_3.id)
    @friendship_3 = UserFriendship.create(user_id: @user_1.id, friend_id: @user_4.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user_1)
#
    visit new_viewing_party_path
  end

  it 'displays movie title of movie selected' do
    expect(page).to have_content('MOVIE TITLE PLACEHOLDER') #fix upon incorporating API
  end

  it 'has field for duration of party with a default value of movie runtime in minutes' do
    # expect(page).to
  end

  it ' does not allow party creation if set to a value less than the duration of the movie' do
  end

  it 'has field for date and time of party' do
  end

  it 'has option to select firends to invite to party if use has friends' do
  end

  it 'has a button to create new party and user is redirected back to dashboard upon party creation' do
  end

  it 'displays new event on user and invitees dashboards' do
  end
end

# As an authenticated user,
# When I visit the new viewing party page,
# I should see the name of the movie title rendered above a form with the following fields:
#
#  Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set
#  to a value less than the duration of the movie
#  When: field to select date
#  Start Time: field to select time
#  Checkboxes next to each friend (if user has friends)
#  Button to create a party
# Details When the party is created, the authenticated user should be redirected back to the dashboard where the new
# event is shown. The event should also be seen by
# any friends that were invited when they log in.
