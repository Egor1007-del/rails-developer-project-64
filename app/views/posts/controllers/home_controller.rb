class HomeController < ApplicationController
  def index
    @posts = Post.includes(:category, :creator).order(created_at: :desc)
  end
end
