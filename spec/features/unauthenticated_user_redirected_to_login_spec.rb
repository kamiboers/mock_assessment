require "rails_helper"

RSpec.feature "User Sign-Up", :type => :feature do
  scenario "unauthenticated user redirected to log in" do
    visit root_path

    expect(current_path).to eq('/welcome')
    expect(page).to have_content('Log In or Sign Up')
    
  end

  scenario "sign up form" do
    demo_email = 'me@gmail.com'
    demo_pw = 'secret'
  
    visit '/welcome'

    click_on 'Sign Up'

    fill_in 'user_email', with: demo_email
    fill_in 'user_password', with: demo_pw
    fill_in 'user_password_confirmation', with: demo_pw

    expect(page).to have_content('Thanks for signing up!')
    expect(current_path).to eq('/dashboard')
    expect(User.count).to eq(1)

  end
    
  end