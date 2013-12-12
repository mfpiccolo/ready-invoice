class AddSfCredentialFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :sf_username_crypted, :string
    add_column :users, :sf_password_crypted, :string
    add_column :users, :sf_security_token_crypted, :string
  end
end
