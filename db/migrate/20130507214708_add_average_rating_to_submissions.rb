class AddAverageRatingToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :average_rating, :decimal
  end
end
