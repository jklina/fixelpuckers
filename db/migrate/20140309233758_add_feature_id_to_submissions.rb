class AddFeatureIdToSubmissions < ActiveRecord::Migration
  def change
    add_column :features, :submission_id, :integer
  end
end
