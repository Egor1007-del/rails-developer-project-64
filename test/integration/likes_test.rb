require "test_helper"

class LikesTest < ActionDispatch::IntegrationTest
  test "guest cannot like post" do
    post_record = posts(:one)
    assert_no_difference("PostLike.count") do
      post post_likes_path(post_record)
    end

    assert_response :redirect
  end

  test "signed in user can like post" do
    sign_in users(:one)
    post_record = posts(:two)

    assert_difference("PostLike.count", 1) do
      post post_likes_path(post_record)
    end

    like = PostLike.last

    assert_equal users(:one).id, like.user_id
    assert_equal post_record.id, like.post_id

    assert_response :redirect
  end

  test "signed in user can unlike post" do
    sign_in users(:one)
    post_record = posts(:two)
    like = post_likes(:one)

    PostLike.create!(user: users(:one), post: post_record)

    assert_difference("PostLike.count", -1) do
      delete post_like_path(post_record, like)
    end

    assert_response :redirect
  end
end
