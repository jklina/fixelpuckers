class AddIndexToSlugsForUsers < ActiveRecord::Migration
  def self.up
    add_index :users, :slug, :unique => true
  end
  def self.down
    remove_index :users, :slug
  end
end
