class AddSubUserKeysToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :user_id, :integer
    add_column :reviews, :submission_id, :integer
  end
end
