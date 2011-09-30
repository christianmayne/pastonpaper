class AddStocknumberToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :stocknumber, :string
  end

  def self.down
    remove_column :documents, :stocknumber
  end
end
