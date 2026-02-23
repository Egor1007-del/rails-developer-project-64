require "test_helper"

class Account::PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get account_posts_index_url
    assert_response :success
  end

  test "should get new" do
    get account_posts_new_url
    assert_response :success
  end

  test "should get create" do
    get account_posts_create_url
    assert_response :success
  end
end
