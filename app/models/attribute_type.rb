class AttributeType < ActiveRecord::Base

  has_many :documents
  named_scope :alphabetically, :order => "name ASC"
end
