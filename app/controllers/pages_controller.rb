class PagesController < ApplicationController
 
 def index
  redirect_to '/login' if !current_user
 end

 def login
  @user = User.new
 end
  
end
