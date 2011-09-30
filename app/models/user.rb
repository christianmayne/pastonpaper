class User < ActiveRecord::Base

  acts_as_authentic

  has_many :documents


  def is_document_owner(document_user_id)
    self.id == document_user_id
  end
end
