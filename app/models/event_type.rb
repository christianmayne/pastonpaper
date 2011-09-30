class EventType < ActiveRecord::Base

  belongs_to :person_event
  named_scope :alphabetically, :order => "name ASC"

end
