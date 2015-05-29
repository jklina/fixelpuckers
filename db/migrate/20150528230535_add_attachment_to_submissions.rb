class AddAttachmentToSubmissions < ActiveRecord::Migration
  def self.up
    add_attachment :submissions, :attachment
  end

  def self.down
    remove_attachment :submissions, :attachment
  end
end
