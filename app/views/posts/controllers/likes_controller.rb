# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @like = current_user.likes.new(post: @post)

    if @like.save
      redirect_to post_path(@post), notice: "Лайк поставлен"
    else
      redirect_to post_path(@post), alert: @post_path.errors.full_messages.to_presence || "Не удалось поставить лайк"
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    @like&.destroy
    redirect_to post_path(@post), notice: "Лайк убран"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
