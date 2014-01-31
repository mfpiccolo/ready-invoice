class CreateLayouts < ActiveRecord::Migration
  def change
    create_table :layouts do |t|
      t.integer :user_id
      t.string :li_name_model
      t.string :li_name_attribute
      t.string :li_description_model
      t.string :li_description_attribute
      t.string :li_rate_model
      t.string :li_rate_attribute
      t.string :li_quantity_model
      t.string :li_quantity_attribute
      t.string :invoice_name_model
      t.string :invoice_name_attribute
    end
  end
end
