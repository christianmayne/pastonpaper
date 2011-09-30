class AddDescriptionToDocumentType < ActiveRecord::Migration
  def self.up
    add_column :document_types, :description, :string
  end

  def self.down
    remove_column :document_types, :description
  end
end
