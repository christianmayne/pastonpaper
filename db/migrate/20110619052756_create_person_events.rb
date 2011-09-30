class CreatePersonEvents < ActiveRecord::Migration
  def self.up
    create_table :person_events do |t|
      t.references     :person
      t.date           :date_event
      t.references     :event_type
      t.string         :street1
      t.string         :street2
      t.string         :town
      t.string         :city
      t.string         :county
      t.string         :state
      t.string         :country
      t.timestamps
    end
  end

  def self.down
    drop_table :person_events
  end
end
