require 'rails_helper'

RSpec.describe 'Registration Page' do

  it 'allows you to register a new user' do
    visit '/registration'

    email = 'Roald@gmail.com'
    password = 'test'

    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on 'Register New User'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Welcome, #{email.downcase}")
  end

  it 'wont create a user if the email already exists' do
    User.create(email: 'roald@gmail.com', password_digest: 'test')
    visit '/registration'

    email = 'roald@gmail.com'
    password = 'test'

    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on 'Register New User'

    expect(current_path).to eq('/registration')
    expect(page).to have_content("Email has already been taken")
  end

  it 'errors when the passwords dont match' do
    visit '/registration'

    email = 'Roald@gmail.com'
    password = 'test'

    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: 'password'

    click_on 'Register New User'

    expect(current_path).to eq('/registration')
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it 'Logs the newly created user in' do
    visit '/registration'

    email = 'roald@gmail.com'
    password = 'test'

    fill_in :email, with: email
    fill_in :password, with: password
    fill_in :password_confirmation, with: password

    click_on 'Register New User'

    new_user = User.last
    expect(new_user.email).to eq(email)
    # expect(session[:user_id]).to eq(User.last.id)
  end
end
