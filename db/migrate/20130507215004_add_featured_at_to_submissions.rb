class AddFeaturedAtToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :featured_at, :date
  end
end
