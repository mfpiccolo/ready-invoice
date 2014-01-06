# == Schema Information
#
# Table name: sf_object_relations
#
#  id          :integer          not null, primary key
#  parent_id   :integer
#  parent_type :string(255)
#  child_id    :integer
#  child_type  :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class SfObjectRelation < ActiveRecord::Base
  belongs_to :parent, class_name: "SfObject"
  belongs_to :child, class_name: "SfObject"
end
