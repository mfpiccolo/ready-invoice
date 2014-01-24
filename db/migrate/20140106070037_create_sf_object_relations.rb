class CreateSfObjectRelations < ActiveRecord::Migration
  def change
    create_table :sf_object_relations do |t|
      t.integer :parent_id
      t.string :parent_type
      t.integer :child_id
      t.string :child_type

      t.timestamps
    end
  end
end
