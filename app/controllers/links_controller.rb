class LinksController < ApplicationController
 
 def index
  @link = Link.new
  redirect_to '/welcome' if !current_user
 end

 def new
  binding.pry
end

end
