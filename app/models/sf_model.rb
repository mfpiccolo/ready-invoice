class SfModel < ActiveRecord::Base
  # will have @record and @type

  # will overwrite the getter method for records to use json_to_ar
end
