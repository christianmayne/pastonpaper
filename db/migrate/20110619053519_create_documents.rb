class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.string      :name
      t.string      :title
      t.integer     :length
      t.integer     :width
      t.integer     :depth
      t.integer     :weight
      t.integer     :edition
      t.integer     :pages
      t.references  :document_type
      t.text        :condition
      t.text        :binding
      t.references  :user
      t.timestamps
    end
  end

  def self.down
    drop_table :documents
  end
end
