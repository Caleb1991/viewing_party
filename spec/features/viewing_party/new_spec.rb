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

  it 'has form to create new party redirecting user to their dashboard when filled in correctly' do
    # need to add in this functionality: has field for duration of party with a default value of movie runtime in minutes
    fill_in :duration, with: 122
    fill_in :date, with: '2021-09-14'
    fill_in :start_time, with: "8:00 PM"

    check 'empanada_luvr@email.com'
    check 'cheese_luvr@email.com'

    click_button('Create Viewing Party')
    expect(current_path).to eq(dashboard_path)

    submitted_viewing_party = Party.last

    expect(submitted_viewing_party.movie_title).to eq('PLACEHOLDER') #fix upon incorporating API
    expect(submitted_viewing_party.duration).to eq(122)
    expect(submitted_viewing_party.date).to eq('2021-09-14')
    expect(submitted_viewing_party.start_time.to_time.strftime('%I:%M %p')).to eq("8:00 PM")
  end

  xit 'does not allow party creation if duration set to a value less than the duration of the movie' do
    flash_message = 'Length of party can not be less than the movei length. Please put in a value that is at least the length of the movie.'

    fill_in :duration, with: 60
    fill_in :date, with: '2021-09-14'
    fill_in :start_time, with: "8:00 PM"

    check 'empanada_luvr@email.com'
    check 'cheese_luvr@email.com'

    click_button('Create Viewing Party')

    expect(current_path).to eq(new_viewing_party_path)
    expect(page).to have_content(flash_message)
  end

  xit 'displays new event on user and invitees dashboards' do
    fill_in :duration, with: 122
    fill_in :date, with: '2021-09-14'
    fill_in :start_time, with: "8:00 PM"

    check 'cat_luvr@email.com'

    click_button('Create Viewing Party')
    expect(current_path).to eq(dashboard_path)

    visit root_path

    click_button 'Log out'
    click_button 'Log me in!'

    fill_in :email, with: 'cat_luvr@email.com'
    fill_in :password, with: 'catz'

    click_button 'Log In'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('MOVIE TITLE PLACEHOLDER')
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
