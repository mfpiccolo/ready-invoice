class Salesforce < ActiveRecord::Base
  belongs_to :user
  has_many :sf_models
end
