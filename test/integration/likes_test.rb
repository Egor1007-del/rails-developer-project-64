# frozen_string_literal: true

require 'test_helper'

class LikesTest < ActionDispatch::IntegrationTest
  test 'guest cannot like post' do
    post_record = posts(:one)

    post post_likes_path(post_record)

    assert_response :redirect

    created_like = PostLike.find_by(
      post_id: post_record.id,
      user_id: nil
    )

    assert_nil created_like
  end

  test 'signed in user can like post' do
    sign_in users(:one)
    post_record = posts(:two)

    post post_likes_path(post_record)

    assert_response :redirect

    created_like = PostLike.find_by(
      user_id: users(:one).id,
      post_id: post_record.id
    )
    assert created_like
  end

  test 'signed in user can unlike post' do
    sign_in users(:one)
    post_record = posts(:two)
    like = PostLike.create!(user: users(:one), post: post_record)

    delete post_like_path(post_record, like)

    assert_response :redirect

    delete_like = PostLike.find_by(id: like.id)

    assert_nil delete_like
  end
end
