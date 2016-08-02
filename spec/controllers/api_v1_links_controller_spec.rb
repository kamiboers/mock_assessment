require 'rails_helper'

RSpec.describe Api::V1::LinksController, type: :controller do

  describe "GET index" do

    it "returns all links belonging to the current user" do
      user = create_current_user_with_two_links
      link3 = user.links.create!(title: "Third Link", url: "http://www.third.com")
      get :index
      result = JSON.parse(response.body)

      expect(result.count).to eq(3)
      expect(result.last['title']).to eq(link3.title)
      expect(result.last['url']).to eq(link3.url)
    end

  end

  describe "PATCH update" do

    it "toggles the read status of the link" do
      user = create_current_user_with_two_links
      link2 = user.links.last
      expect(link2.status).to eq('unread')

      patch :update, { id: link2.id }
      result = JSON.parse(response.body)

      expect(result['status']).to eq('read')
      expect(Link.last.status).to eq('read')
    end

  end

  describe "GET save" do

    it "updates the title and url of the link" do
      user = create_current_user_with_two_links
      link2 = user.links.last
      expect(Link.last.title).to eq('Other Title')
      expect(Link.last.url).to eq('http://www.otherlink.com')

      patch :save, { id: "id-#{link2.id}", contents: "best title\nhttp://www.new.com" }

      expect(Link.last.title).to eq('best title')
      expect(Link.last.url).to eq('http://www.new.com')
    end

  end

end
