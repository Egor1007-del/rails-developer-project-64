# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[index new create]
  def index
    @posts = current_user.posts.includes(:category).order(created_at: :desc)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to root_path, notice: 'Пост создан'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find(params[:id])

    @comment = PostComment.new
    @comment.parent_id = params[:parent_id] if params[:parent_id].present?
    @comments = @post.comments.arrange(order: :created_at)

    @liked_by_me = user_signed_in? && @post.likes.exists?(user_id: current_user.id)
    @likes_count = @post.likes.count
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :category_id)
  end
end
