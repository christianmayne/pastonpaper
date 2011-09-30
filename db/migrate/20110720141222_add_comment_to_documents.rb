class AddCommentToDocuments < ActiveRecord::Migration
  def self.up
    add_column :documents, :comment, :text
  end

  def self.down
    remove_column :documents, :comment
  end
end
