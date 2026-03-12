# frozen_string_literal: true

class PostsTest < ActionDispatch::IntegrationTest
  test "guest cannot access new post page" do
    get new_post_path

    assert_response :redirect
  end

  test "guest cannot create post" do
    assert_no_difference("Post.count") do
      post posts_path, params: {
        post: {
          title: "New title",
          body: "New body",
          category_id: categories(:one).id
        }
      }
    end

    assert_response :redirect
  end

  test "signed in user can access new post page" do
    sign_in users(:one)

    get new_post_path

    assert_response :success
  end

  test "signed in user can create post" do
    sign_in users(:one)

    assert_difference("Post.count", 1) do
      post posts_path, params: {
        post: {
          title: "Test title",
          body: "Test body",
          category_id: categories(:one).id
        }
      }
    end

    created_post = Post.order(:created_at).last

    assert_equal "Test title", created_post.title
    assert_equal "Test body", created_post.body
    assert_equal categories(:one).id, created_post.category_id
    assert_equal users(:one).id, created_post.creator_id

    assert_response :redirect
  end

  test "signed in user cannot create invalid post" do
    sign_in users(:one)

    assert_no_difference("Post.count") do
      post posts_path, params: {
        post: {
          title: "",
          body: "",
          category_id: categories(:one).id
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "user can view post show page" do
    get post_path(posts(:one))

    assert_response :success
  end
end
