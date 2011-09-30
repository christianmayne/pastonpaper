class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string     :name_title
      t.string     :name_first
      t.string     :name_middle
      t.string     :name_last
      t.string     :name_maiden
      t.string     :sex
      t.references :document
      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
