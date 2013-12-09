class CreateSfModels < ActiveRecord::Migration
  def change
    create_table :sf_models do |t|
      t.integer :salesforce_id
      t.string  :model_name
      t.json    :records

      t.timestamps
    end
  end
end
