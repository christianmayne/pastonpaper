class CreateAttributeDocuments < ActiveRecord::Migration
  def self.up
    create_table :attribute_documents do |t|
      t.references    :document
      t.references    :attribute_type
      t.string        :value
      t.date          :date
      t.references    :location
      t.timestamps
    end
  end

  def self.down
    drop_table :attribute_documents
  end
end
