class Api::V1::LinksController < Api::V1::BaseController

  def index
    render json: current_user.links.order(created_at: :asc)
  end

  def alpha
    render json: current_user.links.order(:title)
  end
  
  def update
    link = current_user.links.find_by(id: params[:id])
    link.toggle!(:status)
    render json: link
  end

  def save
    link = Link.find_by(id: params[:id].split('-').last)
    link.update!(title: split_edited_content.first, url: split_edited_content.last)
    render json: link
  end

  private
  
  def link_params
    params.require(:link).permit(:title, :url)
  end

  def split_edited_content
    title = params['contents'].split("\n").first
    url = params['contents'].split("\n")[1]
    return [title, url]
  end

end