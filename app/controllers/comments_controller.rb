# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])

    @comment = @post.comments.build(comment_params)

    @comment.user = current_user

    if @comment.save
      redirect_to post_path(@post), notice: t('comment.added')
    else
      redirect_to post_path(@post), alert: @comment.errors.full_messages.to_sentence
    end
  end

  private

  def comment_params
    params.expect(post_comment: %i[content parent_id])
  end
end
