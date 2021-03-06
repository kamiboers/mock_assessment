require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user
  
  validates :url, :url => true, presence: true, uniqueness: true
  validates :title, presence: true
  enum status: { unread: false, read: true }

  def update_text(title, url)
    update_attributes!(title: title)
    update_attributes!(url: url)
    return self
  end

end
