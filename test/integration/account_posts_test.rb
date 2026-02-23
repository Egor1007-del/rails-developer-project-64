require "test_helper"
class AccountPostsTest < ActionDispatch::IntegrationTest
  test "GET /account/posts redirect guest to sign in" do
    get account_posts_path
    assert_redirected_to new_user_session_path
  end

  test "GET /account/posts for signed in user" do
    sign_in users(:one)
    get account_posts_path
    assert { response.status == 200 }
  end

  test "GET /account/post/new redirect guest to sign in" do
    get new_account_post_path
    assert_redirected_to new_user_session_path
  end

  test "GET /account/post/new for signed in user" do
    sign_in users(:one)
    get new_account_post_path
    assert { response.status == 200 }

    assert_select "form"
  end

  test "POST /account/posts create post for user" do
    sign_in users(:one)

    assert_difference("Post.count", +1) do
      post account_posts_path, params: {
        post: {
          title: "New title",
          body: "New body",
          category_id: categories(:one).id
        }
      }
    end

    created = Post.last

    assert { created.title == "New title" }
    assert { created.creator_id == users(:one).id }
  end

  test "GET /account/posts/:id redirects guest to sign in" do
    get account_post_path(posts(:one))
    assert_redirected_to new_user_session_path
  end

  test "GET /account/posts/:id is ok for signed in user" do
    sign_in users(:one)

    get account_post_path(posts(:one))

    assert { response.status == 200 }
  end
end
