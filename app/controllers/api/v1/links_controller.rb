class Api::V1::LinksController < Api::V1::BaseController

  def index
    render json: Link.order(created_at: :asc)
  end

  # def create
  #   idea = Idea.new(idea_params)
  #   if idea.save
  #     render json: idea
  #   end
  # end

  def update
    link = Link.find_by(id: params[:id])
    link.toggle(:status)
    link.save!
    render json: link
  end

  # def upvote
  #   @idea = Idea.find_by(id: params[:id])
  #   render json: @idea.thumbs_up
  # end

  # def downvote
  #   @idea = Idea.find_by(id: params[:id])
  #   render json: @idea.thumbs_down
  # end

  def save
    link = Link.find_by(id: params[:id].split('-').last)
    render json: link.update_text(split_edited_content.first, split_edited_content.last)
  end

  # def destroy
  #   @idea = Idea.find_by(id: params[:id])
  #   @idea.idea_tags.destroy_all
  #   render json: @idea.destroy
  # end

  # def tags
  #   tags_list = Idea.find_by(id: params[:id]).tags.pluck(:name).join(",")
  #   render json: { tags: tags_list }
  # end

  # def all_tags
  #   render json: Tag.all.pluck(:name)
  # end

  # def by_tag
  #   render json: Idea.joins(:tags).where('tags.name = ?', params[:tag])
  # end

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