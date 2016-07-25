require 'uri'

class Link < ActiveRecord::Base
  belongs_to :user
  
  validates :url, :format => URI::regexp(%w(http https)), uniqueness: true

end
