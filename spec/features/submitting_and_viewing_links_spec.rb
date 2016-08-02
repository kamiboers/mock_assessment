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
    user = User.create(email: "example@test.com", password: "test")
    ApplicationController.any_instance.stub(:current_user).and_return(user)
    visit '/'

    fill_in :link_url, with: 'http://www.link.com'
    fill_in :link_title, with: 'TITLE'
    click_on 'Create Link'

    expect(Link.count).to eq(1)
    expect(Link.first.title).to eq('TITLE')
    expect(Link.first.status).to eq('unread')
    expect(page).to have_content('Link Saved') 
  end

  scenario "invalid uri rejected" do
    user = User.create(email: "example@test.com", password: "test")
    ApplicationController.any_instance.stub(:current_user).and_return(user)
    visit '/'

    fill_in :link_url, with: ':/clearlynotalink.com'
    fill_in :link_title, with: 'TITLE'
    click_on 'Create Link'

  expect(page).to have_content('Link is invalid.')
    expect(Link.count).to eq(0)
  end


end