# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :set_post

  def create
    authenticate_user!
    @post.likes.find_or_create_by(user: current_user)
    redirect_to post_path(@post)
  end

  def destroy
    authenticate_user!
    @like = current_user.likes.find_by(id: params[:id])
    @like&.destroy
    redirect_to post_path(@post), notice: t('.success')
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
