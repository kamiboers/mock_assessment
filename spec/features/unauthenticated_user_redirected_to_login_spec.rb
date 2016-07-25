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
    click_on 'Create Account'

    expect(current_path).to eq('/')
    expect(User.count).to eq(1)

  end

  scenario "users cannot duplicate email address" do
    demo_email = 'me@gmail.com'
    demo_pw = 'secret'
    User.create!(email: demo_email, password: demo_pw)

    visit '/welcome'
    click_on 'Sign Up'
    fill_in 'user_email', with: demo_email
    fill_in 'user_password', with: demo_pw
    fill_in 'user_password_confirmation', with: demo_pw
    click_on 'Create Account'

    expect(User.count).to eq(1)

  end

  scenario "password and confirmation must match" do
    demo_email = 'me@gmail.com'
    demo_pw = 'secret'

    visit '/welcome'
    click_on 'Sign Up'
    fill_in 'user_email', with: demo_email
    fill_in 'user_password', with: demo_pw
    fill_in 'user_password_confirmation', with: 'wrong'
    click_on 'Create Account'

    expect(User.count).to eq(0)

  end
    
  end

# I cannot sign up with an email address that has already been used.
# Password and confirmation must match.
# Upon submitting this information, I should be logged in via a cookie and redirected to the "Links Index" page.

# Sign Out

# As an authenticated user viewing the index page, I should see a link to "Sign Out". This should clear my cookies and redirect me back to the login page.