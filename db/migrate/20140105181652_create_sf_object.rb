class CreateSfObject < ActiveRecord::Migration
  def change
    create_table :sf_objects do |t|
      t.integer  :user_id
      t.string   :oid
      t.string   :otype
      t.json     :data
      t.hstore   :ohash
      t.datetime :last_modified
      t.datetime :last_checked

      t.timestamps
    end
  end
end
