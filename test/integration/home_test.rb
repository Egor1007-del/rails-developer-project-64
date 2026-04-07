# frozen_string_literal: true

require 'test_helper'
class HomeTest < ActionDispatch::IntegrationTest
  test 'GET / main public page' do
    get root_path
    assert { response.status == 200 }
  end

  test 'GET / redirect to main page when signed in' do
    sign_in users(:one)

    get root_path

    assert { response.status == 200 }
    assert { response.body.include?(I18n.t("posts.index.title")) }
  end
end
