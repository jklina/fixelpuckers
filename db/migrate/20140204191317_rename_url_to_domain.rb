class RenameUrlToDomain < ActiveRecord::Migration
  def change
    rename_column :users, :url, :domain
  end
end
