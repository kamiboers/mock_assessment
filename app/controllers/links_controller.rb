class LinksController < ApplicationController
 
  def index
    redirect_to '/welcome' if !current_user
    @links = current_user.links.all if current_user
    @link = Link.new
  end

  def new
  end

  def create
    link = Link.new(link_params)
    if current_user.links << link
      flash[:success] = "Link Saved"
      redirect_to root_path
    else
      flash[:error] = "Link is invalid."
      redirect_to root_path
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url)
  end

end
