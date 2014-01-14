class AddClearanceColumnsMissed < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :encrypted_password, :limit => 128, :null => false
      t.string :confirmation_token, :limit => 128
    end
  end
end
