class PlyRelation < ActiveRecord::Base
  belongs_to :parent, class_name: 'PlyObject'
  belongs_to :child, class_name: 'PlyObject'
end
