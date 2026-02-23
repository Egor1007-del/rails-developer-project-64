class PostsController < ApplicationController
  def index
    @posts = Post.includes(:category, :creator).order(created_at: :desc)
  end

  def show
    @post = Post.includes(:category, :creator).find(params[:id])
  end
end
