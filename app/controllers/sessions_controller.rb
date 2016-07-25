class SessionsController < ApplicationController


def new
end

def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to links_path
    else
      flash.now[:error] = "Invalid. Try Again."
      render :new
    end
  end

def destroy
  session.clear
  flash[:notice] = "Successfully Logged Out"
  redirect_to root_path
end


end