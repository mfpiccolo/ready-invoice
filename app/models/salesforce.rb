# == Schema Information
#
# Table name: salesforces
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  models     :string(255)      default([])
#  data       :json
#  created_at :datetime
#  updated_at :datetime
#

class Salesforce < ActiveRecord::Base
  belongs_to :user
  has_many :sf_models
end
