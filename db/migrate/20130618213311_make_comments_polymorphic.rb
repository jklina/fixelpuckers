class MakeCommentsPolymorphic < ActiveRecord::Migration
  def change
    change_table :comments do |t|
      t.remove :user_id
      t.references :commentable, :polymorphic => true
    end
  end
end
