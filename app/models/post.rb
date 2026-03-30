# frozen_string_literal: true

class Post < ApplicationRecord
  POST_PREVIEW_LENGTH = 220

  belongs_to :category, inverse_of: :posts
  belongs_to :creator, class_name: 'User', inverse_of: :posts
  has_many :comments, class_name: 'PostComment', dependent: :destroy, inverse_of: :post
  has_many :likes, class_name: 'PostLike', dependent: :destroy, inverse_of: :post

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :body, presence: true, length: { minimum: 10, maximum: 500 }

  def preview
    body.truncate(POST_PREVIEW_LENGTH)
  end
end
