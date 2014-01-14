class AddClearanceToUsers < ActiveRecord::Migration
  def self.up
    change_table :users  do |t|
      t.string :remember_token, :limit => 128
      t.remove :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
    end

    add_index :users, :remember_token
  end

  def self.down
    change_table :users do |t|
      t.remove :remember_token
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      t.string   :confirmation_token
      t.string   :confirmed_at
      t.string   :confirmation_sent_at
      t.string   :unconfirmed_email
    end
    add_index :users, :reset_password_token, :unique => true
  end
end
