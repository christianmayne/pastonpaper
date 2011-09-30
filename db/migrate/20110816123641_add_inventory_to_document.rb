class AddInventoryToDocument < ActiveRecord::Migration
  def self.up
    add_column :documents, :purchase_date, :datetime
    add_column :documents, :purchase_vendor, :string
    add_column :documents, :purchase_price, :decimal
    add_column :documents, :sale_date, :datetime
    add_column :documents, :sale_purchaser, :string
    add_column :documents, :sale_price, :decimal
  end

  def self.down
    remove_column :documents, :sale_price
    remove_column :documents, :sale_purchaser
    remove_column :documents, :sale_date
    remove_column :documents, :purchase_price
    remove_column :documents, :purchase_vendor
    remove_column :documents, :purchase_date
  end
end
