class AddColumnsInUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :name

    add_column :users, :first_name,   :string
    add_column :users, :last_name,    :string
    add_column :users, :address1,     :string
    add_column :users, :address2,     :string
    add_column :users, :city,    :string
    add_column :users, :county,     :string
    add_column :users, :post_code,    :string
    add_column :users, :country,     :string
    add_column :users, :tel_number,     :string
    add_column :users, :mobile_number,    :string
    add_column :users, :date_of_birth,    :date
    add_column :users, :is_active, :boolean ,:default => true
  end

  def self.down
    
    add_column :users,  :name,   :string
    
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :address1
    remove_column :users, :address2
    remove_column :users, :city
    remove_column :users, :county
    remove_column :users, :post_code
    remove_column :users, :country
    remove_column :users, :tel_number
    remove_column :users, :mobile_number
    remove_column :users, :date_of_birth
    remove_column :users, :is_active
  end
end
