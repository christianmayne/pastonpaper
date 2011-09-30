class AddStatusToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :document_status_id, :integer
  end

  def self.down
    remove_column :documents, :document_status_id
  end
end
