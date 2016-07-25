require "rails_helper"

RSpec.feature "Links CRUD", :type => :feature do

  scenario "logged in user views links" do
    user = User.create(email: "example@test.com", password: "test")
    ApplicationController.any_instance.stub(:current_user).and_return(user)
    visit '/'

    expect(current_path).to eq('/')
    expect(page).to have_content('Links Index')
  end

  scenario "logged in user adds links" do
    visit '/'

    fill_in :link_url, with: 'http://www.link.com'
    fill_in :link_title, with: 'TITLE'
    click_on 'Submit Link'

    expect(Link.count).to eq(1)
    expect(Link.first.title).to eq('TITLE')
    expect(Link.first.status).to eq(false)

      visit '/'
  expect(page).to have_content('TITLE')
  expect(page).to have_content('http://www.link.com')
      
  end

  # scenario "invalid uri rejected" do
  #   visit '/'

  #   fill_in :link_url, with: ':/clearlynotalink.com'
  #   fill_in :link_title, with: 'TITLE'
  #   click_on 'Submit Link'

  # expect(page).to have_content('Link is invalid.')
  #   expect(Link.count).to eq(0)
  # end


end
# 
# As an authenticated user viewing the main page (links#index), I should see a simple form to submit a link.

# The Link model should include:

# A valid URL location for the link
# A title for the link
# Additionally, all links have a read status that is either true or false. This column will default to false.

# Submitting an invalid link should result in an error message being displayed.

# Hint: Use Ruby's built in URI.parse method to determine if a link is a valid URL or not. This StackOverflow post has more information. Alternatively, you could use a gem like this one.

# Once a link has been submitted, loading the index page should display all of my links.