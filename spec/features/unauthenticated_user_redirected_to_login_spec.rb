require "rails_helper"

RSpec.feature "User Sign-Up", :type => :feature do
  scenario "unauthenticated user redirected to log in" do
    visit root_path

    expect(current_path).to eq('/login')
    expect(page).to have_content('Log In or Sign Up')
    
  end

  scenario "sign up form" do
    demo_email = 'me@gmail.com'
    demo_pw = 'secret'
  
    visit '/login'
    click_on 'Sign Up'

    fill_in 'email', with: demo_email
    fill_in 'password', with: demo_pw
    fill_in 'password_confirm', with: demo_pw

    expect(page).to have_content('Thanks for signing up!')
    expect(current_path).to eq('/dashboard')
    expect(User.count).to eq(1)

    visit '/login'

    expect(current_path).to eq('/dashboard')
  end
    
  end