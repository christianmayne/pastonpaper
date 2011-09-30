class AddHiddenToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :hidden, :boolean
  end

  def self.down
    remove_column :documents, :hidden
  end
end
