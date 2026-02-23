module Account
  class PostsController < ApplicationController
    before_action :authenticate_user!
    def index
      @posts = current_user.posts.includes(:category).order(created_at: :desc)
    end

    def new
      @post = current_user.posts.build
    end

    def show
      @post = current_user.posts.find(params[:id])
    end

    def create
      @post = current_user.posts.build(post_params)

      if @post.save
        redirect_to account_posts_path, notice: "Пост создан"
      else
        render :new, status: :unprocessable_entity
      end
    end

    private
    def post_params
      params.require(:post).permit(:title, :body, :category_id)
    end
  end
end
