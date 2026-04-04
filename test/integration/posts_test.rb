# frozen_string_literal: true

class PostsTest < ActionDispatch::IntegrationTest
  test 'guest cannot access new post page' do
    get new_post_path

    assert_response :redirect
  end

  test 'guest cannot create post' do
    post_params = {
      title: 'New title',
      body: 'New body',
      category_id: categories(:one).id
    }

    post posts_path, params: { post: post_params }

    assert_response :redirect

    created_post = Post.find_by(
      title: post_params[:title],
      body: post_params[:body],
      category_id: post_params[:category_id]
    )
    assert_nil created_post
  end

  test 'signed in user can access new post page' do
    sign_in users(:one)

    get new_post_path

    assert_response :success
  end

  test 'signed in user can create post' do
    sign_in users(:one)

    post_params = {
      title: 'Test title Test title',
      body: 'Test body Test body',
      category_id: categories(:one).id
    }

    post posts_path, params: { post: post_params }

    assert_response :redirect
    created_post = Post.find_by(
      title: post_params[:title],
      body: post_params[:body],
      category_id: post_params[:category_id],
      creator_id: users(:one).id
    )
    assert created_post
  end

  test 'signed in user cannot create invalid post' do
    sign_in users(:one)

    post_params = {
      title: '',
      body: '',
      category_id: categories(:one).id
    }

    post posts_path, params: { post: post_params }

    assert_response :unprocessable_entity

    created_post = Post.find_by(
      title: post_params[:title],
      body: post_params[:body],
      category_id: post_params[:category_id],
      creator_id: users(:one).id
    )

    assert_nil created_post
  end

  test 'user can view post show page' do
    get post_path(posts(:one))

    assert_response :success
  end
end
