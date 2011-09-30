class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string        :street1
      t.string        :street2
      t.string        :town
      t.string        :city
      t.string        :county
      t.string        :state
      t.string        :country
      t.string        :text
      t.references    :document
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
