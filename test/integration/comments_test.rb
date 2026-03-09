# frozen_string_literal: true

require 'test_helper'

class CommentsTest < ActionDispatch::IntegrationTest
  test 'guest cannot create comment' do
    post_record = posts(:one)
    assert_no_difference('PostComment.count') do
      post post_comments_path(post_record), params: {
        post_comment: { content: 'Hello' }
      }
    end
    assert_response :redirect
  end

  test 'signed in user can create root comment' do
    sign_in users(:one)
    post_record = posts(:one)

    assert_difference('PostComment.count', 1) do
      post post_comments_path(post_record), params: {
        post_comment: { content: 'Root comment' }
      }
      comment = PostComment.order(:created_at).last
      assert_equal post_record.id, comment.post_id
      assert_equal users(:one).id, comment.user_id
      assert_equal 'Root comment', comment.content
      assert comment.is_root?
    end
  end

  test 'signed in user can create nested comment' do
    sign_in users(:one)
    post_record = posts(:one)
    parent = post_comments(:root_comment)

    assert_difference('PostComment.count', 1) do
      post post_comments_path(post_record), params: {
        post_comment: { content: 'reply', parent_id: parent.id }
      }
    end

    comment = PostComment.order(:created_at).last
    assert_equal parent.id, comment.parent_id
    assert_equal 'reply', comment.content
    assert_response :redirect
  end

  test 'signed in user can create deep nested comment' do
    sign_in users(:one)
    post_record = posts(:one)
    parent = post_comments(:reply_1)

    assert_difference('PostComment.count', 1) do
      post post_comments_path(post_record), params: {
        post_comment: { content: 'Deep reply', parent_id: parent.id }
      }
    end

    comment = PostComment.order(:created_at).last
    assert_equal parent.id, comment.parent_id
    assert_equal 'Deep reply', comment.content
    assert_response :redirect
  end
end
