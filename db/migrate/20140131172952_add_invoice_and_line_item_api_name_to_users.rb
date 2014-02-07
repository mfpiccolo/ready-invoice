class AddInvoiceAndLineItemApiNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :invoice_api_name, :string
    add_column :users, :line_item_api_name, :string
    rename_column :users, :model_names, :other_model_names
  end
end
