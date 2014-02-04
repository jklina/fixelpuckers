class AddDefaultValuesForViewsAndDownloads < ActiveRecord::Migration
  def change
    change_column :submissions, :views, :integer, default: 0, null: false
    change_column :submissions, :downloads, :integer, default: 0, null: false
    Submission.where(views: nil).update_all({views: 0})
    Submission.where(views: nil).update_all({downloads: 0})
  end
end
