require "rails_helper"

RSpec.feature "authenticated user can edit links" do

  scenario "authenticated updates existing link title" do
    user = create_user_with_two_links
    link2 = user.links.last

    visit root_path
    click_on "Log In"
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: "test"
    click_on 'Log In'

    visit root_path

    within("#link-#{link2.id}") do
      expect(page).to have_content(link2.title)
      click_on "Edit"
      fill_in 'title', with: 'New Title'
      find('.title').native.send_keys(:return)
    end

    expect(link2.title).to eq('New Title')
  end

  scenario "authenticated filters existing links" do
    user = create_user_with_two_links
    link2 = user.links.last
    link2.status = 'read'

    visit root_path
    click_on "Log In"
    fill_in 'session_email', with: user.email
    fill_in 'session_password', with: "test"
    click_on 'Log In'

    visit "/"

    save_and_open_page

  end

end