class AddFriendlyIdToSubmissions < ActiveRecord::Migration
  def self.up
    add_column :submissions, :slug, :string
    add_index :submissions, :slug, :unique => true
  end

  def self.down
    remove_column :submissions, :slug
    remove_index :submissions, :slug
  end
end
