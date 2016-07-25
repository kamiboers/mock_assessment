class Api::V1::LinksController < Api::V1::BaseController

  def index
    render json: current_user.links.order(created_at: :asc)
  end

  def alpha
    render json: current_user.links.order(:title)
  end
  
  def update
    link = current_user.links.find_by(id: params[:id])
    link.toggle(:status)
    link.save!
    render json: link
  end

  private
  
  def link_params
    params.require(:link).permit(:title, :url)
  end

end