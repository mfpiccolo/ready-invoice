class FixOtherModelNames < ActiveRecord::Migration
  def change
    remove_column :users, :other_model_names
    add_column :users, :other_model_names, :string, array: true
  end
end
