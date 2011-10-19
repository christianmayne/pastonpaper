class CreateDocumentPhotos < ActiveRecord::Migration
  def self.up
  add_column :documents, :image_limit, :integer, :default => 4
    
    create_table :document_photos do |t|
		t.integer :document_id
		t.string :photo_file_name
		t.string :photo_content_type
		t.integer :photo_file_size
		t.timestamps
    end
  end

  def self.down
 
	drop_table :document_photos
    remove_column :documents, :image_limit
  
 end
end
