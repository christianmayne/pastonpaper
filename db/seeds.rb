# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

doc_types_1 = DocumentType.find_or_create_by_name(:name => 'Bible')
doc_types_2 = DocumentType.find_or_create_by_name(:name => 'Will')
doc_types_3 = DocumentType.find_or_create_by_name(:name => 'Directory')
doc_types_4 = DocumentType.find_or_create_by_name(:name => 'Newspaper')
doc_types_5 = DocumentType.find_or_create_by_name(:name => 'Letter')
doc_types_6 = DocumentType.find_or_create_by_name(:name => 'Diary')
doc_types_7 = DocumentType.find_or_create_by_name(:name => 'Manuscript')
doc_types_8 = DocumentType.find_or_create_by_name(:name => 'Photograph')
doc_types_9 = DocumentType.find_or_create_by_name(:name => 'Photograph Album')
doc_types_10 = DocumentType.find_or_create_by_name(:name => 'Deed')
doc_types_11 = DocumentType.find_or_create_by_name(:name => 'Indenture')

attr_type_1 = AttributeType.find_or_create_by_name(:name => "Printer")
attr_type_2 = AttributeType.find_or_create_by_name(:name => "Publisher")
attr_type_3 = AttributeType.find_or_create_by_name(:name => "Author")
attr_type_4 = AttributeType.find_or_create_by_name(:name => "Seller")

event_type_1 = EventType.find_or_create_by_name(:name => "Birth")
event_type_2 = EventType.find_or_create_by_name(:name => "Death")
event_type_3 = EventType.find_or_create_by_name(:name => "Baptism")
event_type_4 = EventType.find_or_create_by_name(:name => "Marriage")
event_type_5 = EventType.find_or_create_by_name(:name => "Burial")
event_type_6 = EventType.find_or_create_by_name(:name => "Residence")
