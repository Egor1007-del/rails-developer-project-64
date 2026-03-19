# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :category, inverse_of: :posts
  belongs_to :creator, class_name: 'User', inverse_of: :posts
  has_many :comments, class_name: 'PostComment', dependent: :destroy, inverse_of: :post
  has_many :likes, class_name: 'PostLike', dependent: :destroy, inverse_of: :post

  validates :title, :body, presence: true
end
