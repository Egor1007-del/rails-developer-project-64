class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"
  has_many :post_comments, dependent: :destroy

  validates :title, :body, presence: true
end
