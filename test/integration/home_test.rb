require "test_helper"
class HomeTest < ActionDispatch::IntegrationTest
  test "GET / main public page" do
    get root_path
    assert { response.status == 200 }
  end


  test "GET / redirect to main page when signed in" do
    sign_in users(:one)

    get root_path

    assert { response.status == 200 }
    assert { response.body.include?("Посты") }
  end
end
