class Document < ActiveRecord::Base

  has_many :attribute_documents, :dependent => :destroy
  has_many :locations, :dependent => :destroy
  has_many :people, :dependent => :destroy
  has_many :document_photos, :dependent => :destroy



  belongs_to :document_type
  belongs_to :document_status
  belongs_to :user

  accepts_nested_attributes_for :attribute_documents, :allow_destroy => :true
  accepts_nested_attributes_for :locations, :allow_destroy => :true
  accepts_nested_attributes_for :people, :allow_destroy => :true
  accepts_nested_attributes_for :document_photos, :allow_destroy => :true,:limit => 4,:reject_if => proc { |attributes| attributes['photo'].blank? }
  
  validates_numericality_of :weight, :width, :length, :depth, :message => "only number allowed", :allow_blank => true
  validates_inclusion_of :weight, :in => 0..30000, :message => "weight should be less than 30000", :allow_blank => true
  validates_inclusion_of :width, :in  => 1..1000, :message => "width should be greather than 1 and less than 1000", :allow_blank => true
  validates_inclusion_of :length, :in => 1..1000, :message => "length should be greather than 1 and less than 1000", :allow_blank => true
  validates_inclusion_of :depth, :in  => 1..1000, :message => "depth should be greather than 1 and less than 1000", :allow_blank => true


  
  def self.simple_search(search_param)
    condition  = ""
    condition += "documents.document_type_id = '#{search_param[:document_type_id]}' OR " unless search_param[:document_type_id].blank?
    condition += "documents.status = '#{search_param[:socument_status_id]}' OR " unless search_param[:document_status_id].blank?
    condition += "documents.title LIKE '%#{search_param[:document_title]}%' OR " unless search_param[:document_title].blank?
    condition += "attribute_types.name = 'publisher' AND attribute_documents.value = '#{search_param[:document_publisher]}' OR " unless search_param[:document_publisher].blank?
    condition += "attribute_types.name = 'author' AND attribute_documents.value = '#{search_param[:document_author]}' OR " unless search_param[:document_author].blank?
    condition += "people.name_first = '#{search_param[:firstname]}' OR " unless search_param[:firstname].blank?
    condition += "people.name_maiden = '#{search_param[:lastname]}' OR " unless search_param[:lastname].blank?
    condition += "YEAR(person_events.date_event) >= '#{search_param[:date_birth_from]}'
                  AND YEAR(person_events.date_event) >= '#{search_param[:date_birth_to]}'
                  AND event_types.name = 'Birth' OR " unless search_param[:date_birth_from].blank? && search_param[:date_birth_to].blank?
    condition += "person_events.city = '#{search_param[:city]}' AND event_types.name = 'Birth' OR " unless search_param[:city].blank?
    condition += "person_events.county = '#{search_param[:county]}' AND event_types.name = 'Birth' OR " unless search_param[:county].blank?
    condition += "person_events.country = '#{search_param[:country]}' AND event_types.name = 'Birth' OR " unless search_param[:country].blank?
    condition += "YEAR(person_events.date_event) = '#{search_param[:date_death_from]}'
                  AND event_types.name = 'Death' OR " unless search_param[:date_death_from].blank?
    condition += "YEAR(person_events.date_event) >= '#{search_param[:date_other_from]}'
                  AND YEAR(person_events.date_event) <= '#{search_param[:date_other_to]}'
                  AND event_types.name <> 'Birth' AND event_types.name <> 'Death' OR " unless search_param[:date_other_from].blank? && search_param[:date_other_to].blank?
    condition += "locations.city = '#{search_param[:city]}' OR " unless search_param[:city].blank?
    condition += "locations.city = '#{search_param[:county]}' OR " unless search_param[:county].blank?
    condition += "locations.city = '#{search_param[:country]}' OR " unless search_param[:country].blank?
    unless condition.blank?
      condition += " 1 = 0 "
      self.find_by_sql("SELECT DISTINCT documents.* FROM documents
                        LEFT JOIN users ON users.id = documents.user_id
                        LEFT JOIN document_types ON document_types.id = documents.document_type_id
                        LEFT JOIN document_statuses ON document_statuses.id = documents.document_status_id
                        LEFT JOIN attribute_documents ON attribute_documents.document_id = documents.id
                        LEFT JOIN attribute_types ON attribute_types.id = attribute_documents.attribute_type_id
                        LEFT JOIN people ON people.document_id = documents.id
                        LEFT JOIN person_events ON person_events.person_id = people.id
                        LEFT JOIN event_types ON event_types.id = person_events.event_type_id
                        LEFT JOIN locations ON locations.document_id = documents.id
                        WHERE #{condition} ")
      
    end
  end

  def self.search_people(search_params)
    search_params[:date_birth_to] = '0' if search_params[:date_birth_to] == 'yy'
    search_params[:date_other_to] = '0' if search_params[:date_other_to] == 'yy'
    if !search_params[:date_birth_from].blank? && search_params[:date_birth_from] != 'yyyy'
      date_birth_from = search_params[:date_birth_from].to_i
      unless search_params[:date_birth_to] == '0'
        date_birth_from = search_params[:date_birth_from].to_i - search_params[:date_birth_to].to_i
        date_birth_to = search_params[:date_birth_from].to_i + search_params[:date_birth_to].to_i
      end
    end

    if !search_params[:date_other_from].blank? && !search_params[:date_other_to].blank? &&
       search_params[:date_other_from] != 'yyy'
      date_now   = Time.now.year.to_i
      date_other_from = date_now - search_params[:date_other_from].to_i - search_params[:date_other_to].to_i
      unless search_params[:date_other_to] == '0'
        date_other_to = date_now - search_params[:date_other_from].to_i + search_params[:date_other_to].to_i
      end
    end

    if !search_params[:date_death].blank? && search_params[:date_death] != 'yyyy'
      date_death = search_params[:date_death].to_i
    end

    condition  = ""
    condition += "people.name_first = '#{search_params[:firstname]}' AND " unless search_params[:firstname].blank?
    condition += "people.name_last = '#{search_params[:lastname]}' AND " unless search_params[:lastname].blank?
    if !date_birth_from.blank? && !date_birth_to.blank?
    condition += "(extract(year FROM person_events.date_event) >= '#{date_birth_from}'
                  AND event_types.name = 'Birth') AND "
    condition += "(extract(year FROM person_events.date_event) <= '#{date_birth_to}'
                  AND event_types.name = 'Birth') AND "
    elsif !date_birth_from.blank? && date_birth_to.blank?
      condition += "(extract(year FROM person_events.date_event) = '#{date_birth_from}'
                  AND event_types.name = 'Birth') AND "
    end
    condition += "(event_types.name = 'Death' AND extract(year FROM person_events.date_event) = '#{date_death}')
                  AND " unless date_death.blank?
    condition += "person_events.city = '#{search_params[:city]}' AND " unless search_params[:city].blank?
    condition += "person_events.county = '#{search_params[:county]}' AND " unless search_params[:county].blank?
    condition += "person_events.country = '#{search_params[:country]}' AND " unless search_params[:country].blank?
    condition += "(extract(year FROM person_events.date_event) >= '#{date_other_from}' 
                  AND event_types.name <> 'Death' AND event_types.name <> 'Birth') AND " unless date_other_from.blank?
    condition += "(extract(year FROM person_events.date_event) <= '#{date_other_to}'
                  AND event_types.name <> 'Death' AND event_types.name <> 'Birth') AND " unless date_other_to.blank?

    puts condition
    
    unless condition.blank?
      condition += " 1 = 1 "
      self.find_by_sql("SELECT DISTINCT documents.* FROM documents
                        LEFT JOIN users ON users.id = documents.user_id
                        LEFT JOIN document_types ON document_types.id = documents.document_type_id
                        LEFT JOIN document_statuses ON document_statuses.id = documents.document_status_id
                        LEFT JOIN attribute_documents ON attribute_documents.document_id = documents.id
                        LEFT JOIN attribute_types ON attribute_types.id = attribute_documents.attribute_type_id
                        LEFT JOIN people ON people.document_id = documents.id
                        LEFT JOIN person_events ON person_events.person_id = people.id
                        LEFT JOIN event_types ON event_types.id = person_events.event_type_id
                        WHERE #{condition} ")

    end
  end

  def self.search_location(search_params)

    
    condition_str  = ""

    if !search_params[:date_from].blank? && !search_params[:date_to].blank? &&
       search_params[:date_from] != 'yyyy' && search_params[:date_to] != 'yyyy'
      date_from = search_params[:date_from].to_i
      date_to   = search_params[:date_to].to_i
    end

    if !search_params[:date_other_from].blank? && !search_params[:date_other_to].blank? &&
       search_params[:date_other_from] != 'yyy' && search_params[:date_other_to] != 'yy'
      date_now   = Time.now.year.to_i
      date_other_from = date_now - search_params[:date_other_from].to_i - search_params[:date_other_to].to_i
      date_other_to   = date_now - search_params[:date_other_from].to_i + search_params[:date_other_to].to_i
    end

    
    condition_str += "(locations.town = '#{search_params[:city]}' OR person_events.town = '#{search_params[:city]}') AND " unless search_params[:city].blank?
    condition_str += "(locations.county = '#{search_params[:county]}' OR person_events.county = '#{search_params[:county]}') AND " unless search_params[:county].blank?
    condition_str += "(locations.country = '#{search_params[:country]}' OR person_events.country = '#{search_params[:country]}') AND " unless search_params[:country].blank?

    condition_str += "(extract(year FROM person_events.date_event) >= '#{date_from}'
                  AND extract(year FROM person_events.date_event) <= '#{date_to}') AND " if !date_from.blank? && !date_to.blank?

    condition_str += "(extract(year FROM person_events.date_event) >= '#{date_other_from}' AND
                  extract(year FROM person_events.date_event) <= '#{date_other_to}') AND " if !date_other_from.blank? && !date_other_to.blank?

    puts condition_str
    unless condition_str.blank?
      condition_str += " 1 = 1 "
      self.find_by_sql("SELECT DISTINCT documents.* FROM documents
                        LEFT JOIN users ON users.id = documents.user_id
                        LEFT JOIN document_types ON document_types.id = documents.document_type_id
                        LEFT JOIN document_statuses ON document_statuses.id = documents.document_status_id
                        LEFT JOIN attribute_documents ON attribute_documents.document_id = documents.id
                        LEFT JOIN attribute_types ON attribute_types.id = attribute_documents.attribute_type_id
                        LEFT JOIN people ON people.document_id = documents.id
                        LEFT JOIN person_events ON person_events.person_id = people.id
                        LEFT JOIN event_types ON event_types.id = person_events.event_type_id
                        LEFT JOIN locations ON locations.document_id = documents.id
                        WHERE #{condition_str} ")

    end
  end

  def self.search_document(search_params)
    condition  = ""

    if !search_params[:date_from].blank? && !search_params[:date_to].blank? &&
       search_params[:date_from] != 'yyyy' && search_params[:date_to] != 'yyyy'
      date_from = search_params[:date_from].to_i
      date_to   = search_params[:date_to].to_i
    end

    if !search_params[:date_other_from].blank? && !search_params[:date_other_to].blank? &&
       search_params[:date_other_from] != 'yyy' && search_params[:date_other_to] != 'yy'
      date_now   = Time.now.year.to_i
      date_other_from = date_now - search_params[:date_other_from].to_i - search_params[:date_other_to].to_i
      date_other_to   = date_now - search_params[:date_other_from].to_i + search_params[:date_other_to].to_i
    end
        
    condition += "documents.document_type_id = '#{search_params[:document_type_id]}' AND " unless search_params[:document_type_id].blank?
    condition += "documents.document_status_id = '#{search_params[:document_status_id]}' AND " unless search_params[:document_status_id].blank?
    condition += "documents.title = '#{search_params[:document_title]}' AND " unless search_params[:document_title].blank?
    condition += "attribute_types.name = 'publisher' AND attribute_documents.value = '#{search_params[:document_publisher]}' AND " unless search_params[:document_publisher].blank?
    condition += "attribute_types.name = 'author' AND attribute_documents.value = '#{search_params[:document_author]}' AND " unless search_params[:document_author].blank?


    condition += "(extract(year FROM person_events.date_event) >= '#{date_from}'
                  AND extract(year FROM person_events.date_event) <= '#{date_to}') AND " if !date_from.blank? && !date_to.blank?

    condition += "(extract(year FROM person_events.date_event) >= '#{date_other_from}' AND
                  extract(year FROM person_events.date_event) <= '#{date_other_to}') AND " if !date_other_from.blank? && !date_other_to.blank?


    puts condition
    unless condition.blank?
      condition += " 1 = 1 "
      self.find_by_sql("SELECT DISTINCT documents.* FROM documents
                        LEFT JOIN users ON users.id = documents.user_id
                        LEFT JOIN document_types ON document_types.id = documents.document_type_id
                        LEFT JOIN document_statuses ON document_statuses.id = documents.document_status_id   
                        LEFT JOIN attribute_documents ON attribute_documents.document_id = documents.id
                        LEFT JOIN attribute_types ON attribute_types.id = attribute_documents.attribute_type_id
                        LEFT JOIN people ON people.document_id = documents.id
                        LEFT JOIN person_events ON person_events.person_id = people.id
                        LEFT JOIN event_types ON event_types.id = person_events.event_type_id
                        LEFT JOIN locations ON locations.document_id = documents.id
                        WHERE #{condition} ")

    end
  end

  def people_list(firstname, lastname)
    self.people.find(:all, :conditions => ["name_first =? AND name_last =? ", "#{firstname}", "#{lastname}"]) unless self.people.blank?
  end
end
