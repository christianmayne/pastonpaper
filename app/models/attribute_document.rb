class AttributeDocument < ActiveRecord::Base

  belongs_to :document
  belongs_to :location
  belongs_to :attribute_type

end
