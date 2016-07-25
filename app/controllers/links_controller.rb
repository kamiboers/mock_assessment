class LinksController < ApplicationController
 
 def index
  redirect_to '/welcome' if !current_user
 end

end
