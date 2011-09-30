class PersonEvent < ActiveRecord::Base

  belongs_to :person
  belongs_to :event_type

  
  named_scope :born, :conditions => {:event_type_id => 1}

end
