class CreateSalesforces < ActiveRecord::Migration
  def change
    create_table :salesforces do |t|
      t.integer :user_id
      t.string   :models, array: true, default: '{}'
      t.json    :data

      t.timestamps
    end
  end
end
