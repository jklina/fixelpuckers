class AddViewsAndDownloadsToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :views, :integer
    add_column :submissions, :downloads, :integer
  end
end
