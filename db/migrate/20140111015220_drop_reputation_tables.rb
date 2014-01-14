class DropReputationTables < ActiveRecord::Migration
  def change
    drop_table :rs_reputation_messages
    drop_table :rs_evaluations
    drop_table :rs_reputations
  end
end
