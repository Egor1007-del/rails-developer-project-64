# frozen_string_literal: true

class CreatePostComments < ActiveRecord::Migration[8.1]
  def change
    create_table :post_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.text :content, null: false
      t.string :materialized_path2, null: false, default: ''

      t.timestamps
    end
    add_index :post_comments, :materialized_path2
  end
end
