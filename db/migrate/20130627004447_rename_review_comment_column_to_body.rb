class RenameReviewCommentColumnToBody < ActiveRecord::Migration
  def change
    rename_column :reviews, :comment, :body
  end
end
