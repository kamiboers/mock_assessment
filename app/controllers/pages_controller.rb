class PagesController < ApplicationController
 
 def index
  redirect_to '/welcome' if !current_user
 end

 def welcome
 end
  
end
