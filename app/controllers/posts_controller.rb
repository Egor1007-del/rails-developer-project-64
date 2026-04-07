# frozen_string_literal: true

class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])

    @comment = current_user&.comments&.build
    @comments = @post.comments.includes(:user).arrange(order: { created_at: :desc })

    @user_like = @post.likes.find_by(user: current_user)
    @likes_count = @post.likes_count
  end

  def new
    authenticate_user!
    @post = current_user.posts.build
    @categories = Category.order(:name)
  end

  def create
    authenticate_user!
    @post = current_user.posts.build(post_params)
    @categories = Category.order(:name)

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
