# frozen_string_literal: true

class ReplaceMaterializePath2WithAncestryInPostComments < ActiveRecord::Migration[8.1]
  def change
    add_column :post_comments, :ancestry, :string
    add_index :post_comments, :ancestry

    remove_index :post_comments, :materialized_path2
    remove_column :post_comments, :materialized_path2, :string
  end
end
