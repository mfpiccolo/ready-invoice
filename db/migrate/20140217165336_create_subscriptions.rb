class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string  :email
      t.integer :plan_id
      t.string  :stripe_token
      t.integer :user_id
      t.string  :stripe_cus_id

      t.timestamps
    end
  end
end
