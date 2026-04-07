# frozen_string_literal: true

require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  test 'guest cannot create comment' do
    post_record = posts(:one)
    comment_params = { content: 'Hello' }

    post post_comments_path(post_record), params: {
      post_comment: comment_params
    }

    assert { response.redirect? }

    created_comment = PostComment.find_by(
      post_id: post_record.id,
      content: comment_params[:content]
    )

    assert { created_comment.nil? }
  end

  test 'signed in user can create root comment' do
    sign_in users(:one)
    post_record = posts(:one)

    comment_params = { content: 'Root comment' }

    post post_comments_path(post_record), params: {
      post_comment: comment_params
    }
    assert { response.redirect? }

    created_comment = PostComment.find_by(
      post_id: post_record.id,
      user_id: users(:one).id,
      content: comment_params[:content]
    )

    assert { created_comment }
  end

  test 'signed in user can create nested comment' do
    sign_in users(:one)
    post_record = posts(:one)
    parent = post_comments(:root_comment)
    comment_params = { content: 'reply reply reply', parent_id: parent.id }

    post post_comments_path(post_record), params: {
      post_comment: comment_params
    }

    assert { response.redirect? }

    created_comment = PostComment.find_by(
      user_id: users(:one).id,
      post_id: post_record.id,
      content: comment_params[:content]
    )

    assert { created_comment }
    assert { parent == created_comment.parent }
  end

  test 'signed in user can create deep nested comment' do
    sign_in users(:one)
    post_record = posts(:one)
    parent = post_comments(:reply1)
    comment_params = { content: 'reply reply reply', parent_id: parent.id }

    post post_comments_path(post_record), params: {
      post_comment: comment_params
    }

    assert { response.redirect? }

    created_comment = PostComment.find_by(
      user_id: users(:one).id,
      post_id: post_record.id,
      content: comment_params[:content]
    )

    assert { created_comment }
    assert { parent == created_comment.parent }
  end
end
