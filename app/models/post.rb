class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"

  validates :title, :body, presence: true
end
