class AddPreviewToFeatures < ActiveRecord::Migration
  def self.up
    add_attachment :features, :preview
  end

  def self.down
    remove_attachment :features, :preview
  end
end
