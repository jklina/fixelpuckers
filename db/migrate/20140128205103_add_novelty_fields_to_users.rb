class AddNoveltyFieldsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :url
      t.string :location
    end
  end
end
