class AddTrashedToSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :trashed, :boolean, default: false, null: false
  end
end
