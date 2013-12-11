# == Schema Information
#
# Table name: users
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  email         :string(255)
#  provider      :string(255)
#  uid           :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#  refresh_token :string(255)
#

class User < ActiveRecord::Base
  has_one :salesforce

  rolify
  # attr_accessible :role_ids, :as => :admin
  # attr_accessible :provider, :uid, :name, :email

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

  # Overwrites setter because controller might send blanks in array
  def model_names=(array)
    array.delete("")
    write_attribute(:model_names, array)
  end

  def invoice_api_name
    model_names.first
  end
end
