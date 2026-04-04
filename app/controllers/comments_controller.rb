# frozen_string_literal: true

class CommentsController < ApplicationController
  def create
    authenticate_user!
    post = Post.find(params[:post_id])

    comment = post.comments.build(comment_params)

    comment.user = current_user

    if comment.save
      redirect_to post_path(post), notice: t('.success')
    else
      flash[:error] = comment.errors.full_messages.join('. ')
      redirect_to post_path(post)
    end
  end

  private

  def comment_params
    params.expect(post_comment: %i[content parent_id])
  end
end
