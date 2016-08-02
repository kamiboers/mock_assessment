require 'rails_helper'

RSpec.describe Link, type: :model do

  context "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_uniqueness_of(:url) }
  end   

  context "default link properties" do
    it "defaults to a status of 'unread'" do
      link = create_link

      expect(link.status).to eq('unread')
    end
  end

end
