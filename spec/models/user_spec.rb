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

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end
