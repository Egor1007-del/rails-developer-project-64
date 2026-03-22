# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :posts, dependent: :destroy, inverse_of: :category

  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
end
