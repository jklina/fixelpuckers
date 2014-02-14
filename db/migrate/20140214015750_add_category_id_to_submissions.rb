class AddCategoryIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :category_id, :integer
  end
end
