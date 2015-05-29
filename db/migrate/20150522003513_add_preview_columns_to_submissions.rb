class AddPreviewColumnsToSubmissions < ActiveRecord::Migration
  def self.up
    add_attachment :submissions, :preview
  end

  def self.down
    remove_attachment :submissions, :preview
  end
end
