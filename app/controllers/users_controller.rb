class UsersController < ApplicationController
 
 def new
  @user = User.new
 end

  def create
    @user = User.new(user_params)
    if @user.save
      cookies[:user_id] = @user.id
      redirect_to dashboard_path, notice: "Thanks for signing up!"
    else
      render :new, danger: @user.errors.full_messages.join(", ")
    end
  end
  

  private

   def user_params
    params.require(:user).permit(:email, :password)
  end

end
