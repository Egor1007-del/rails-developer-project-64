class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_ancestry ancestry_column: :materialized_path2,
               ancestry_format: :materialized_path2

  validates :content, presence: true
end
