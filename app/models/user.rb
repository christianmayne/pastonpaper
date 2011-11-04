class User < ActiveRecord::Base
  acts_as_authentic  

  validates :first_name,:last_name , :presence => true
  validates :password, :confirmation => true,
                       :length => { :within => 6..20 },
                       :presence => true,
                       :if => :password_required?

  #validate :dob_date_less, :dob_date_greater 
  validates :email,:uniqueness => true
  
  
  has_many :documents


  def is_document_owner(document_user_id)
    self.id == document_user_id
  end
  
  def name
      [self.first_name, self.last_name].delete_if{|ad_elem| ad_elem.blank?}.join(' ')

  end
  
   def password_required?

      crypted_password.blank? || password.present? 
      
    end
    
 
  def dob_date_less
    if !date_of_birth.blank? and date_of_birth > Date.today
      errors.add(:date_of_birth, "can't be in future")
    end
  end
  
  
  def dob_date_greater
    if !date_of_birth.blank? and date_of_birth < Date.today - 100.years
      errors.add(:date_of_birth, "can't be more than 100 years")
    end
  end
  

end
