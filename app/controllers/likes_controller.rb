class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @post_like = current_user.post_likes.new(post: @post)

    if @post_like.save
      redirect_to post_path(@post), notice: "Лайк поставлен"
    else
      redirect_to post_path(@post), alert: @post_path.errors.full_messages.to_presence || "Не удалось поставить лайк"
    end
  end

  def destroy
    current_user.post_likes.find_by!(post: @post).destroy
    redirect_to post_path(@post), notice: "Лайк убран"
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
