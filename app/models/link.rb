require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user
  
  validates :url, :url => true, uniqueness: true
  enum status: { unread: false, read: true }

end
