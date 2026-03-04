class PostsController < ApplicationController
  def index
    @posts = Post.includes(:category, :creator).order(created_at: :desc)
  end

  def show
    @post = Post.includes(:category, :creator).find(params[:id])

    @comment = PostComment.new
    @comment.parent_id = params[:parent_id] if params[:parent_id].present?
    @comments = @post.post_comments.arrange(order: :created_at)
  end
end
