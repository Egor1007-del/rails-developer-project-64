class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, foreign_key: :creator_id, dependent: :destroy
  has_many :comments, class_name: "PostComment", dependent: :destroy
  has_many :post_likes, dependent: :destroy
end
