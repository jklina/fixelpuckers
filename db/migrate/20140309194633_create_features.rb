class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
