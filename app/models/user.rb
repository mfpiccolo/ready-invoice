# == Schema Information
#
# Table name: users
#
#  id                        :integer          not null, primary key
#  name                      :string(255)
#  email                     :string(255)
#  provider                  :string(255)
#  uid                       :string(255)
#  created_at                :datetime
#  updated_at                :datetime
#  refresh_token             :string(255)
#  model_names               :string(255)
#  sf_username_crypted       :string(255)
#  sf_password_crypted       :string(255)
#  sf_security_token_crypted :string(255)
#

class User < ActiveRecord::Base
  has_many :plies
  has_many :invoices
  has_one :layout

  after_initialize :define_sf_scopes

  attr_encrypted :username, :password, :security_token, :key => "a secret key", :prefix => 'sf_', :suffix => '_crypted'

  # TODO Fix rolify problem.  Guard won't run with rolify
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

  def sf_credentials
    { username: username, password: password, security_token: security_token }
  end

  def define_sf_scopes
    # pluralize is not perfect.  ie. Merchandise__c => merchandises
    if model_names.present?
      model_names.each do |name|
        define_singleton_method(TextHelper.pluralize(name.gsub("__c", "").downcase)) do
          plies.where(otype: name)
        end
      end
    end
  end

end
