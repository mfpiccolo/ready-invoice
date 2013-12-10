class AddModelNamesToUser < ActiveRecord::Migration
  def change
    add_column :users, :model_names, :string, array: true
  end
end
