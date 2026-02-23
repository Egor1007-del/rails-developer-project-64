class PostsTest < ActionDispatch::IntegrationTest
  test "GET /post/:id public viewing page" do
    get post_path(posts(:one))
    assert { response.status == 200 }
  end
end
