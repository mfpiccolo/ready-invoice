class SfObjectRelation < ActiveRecord::Base
  belongs_to :parent, class_name: "SfObject"
  belongs_to :child, class_name: "SfObject"
end
