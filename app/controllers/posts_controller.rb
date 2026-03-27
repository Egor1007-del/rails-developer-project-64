# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!, only: %i[new create]
  before_action :set_categories, only: %i[new create]

  def show
    @post = Post.find(params[:id])

    @comment = PostComment.new
    @comment.parent_id = params[:parent_id] if params[:parent_id].present?
    @comments = @post.comments.includes(:user).arrange(order: { created_at: :desc })

    @liked_by_me = user_signed_in? && @post.likes.exists?(user_id: current_user.id)
    @likes_count = @post.likes_count
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to post_path(@post), notice: t('.success')
    else
      render :new, status: :unprocessable_content
    end
  end

  private

  def post_params
    params.expect(post: %i[title body category_id])
  end

  def set_categories
    @categories = Category.order(:name)
  end
end
