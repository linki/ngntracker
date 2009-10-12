# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

['Messe Berlin', 'NürnbergMesse', 'Hannover Messe'].each do |name|
  Organizer.find_or_create_by_name(name)
end

['ITB', 'IFA'].each do |name|
  portal = Portal.find_or_initialize_by_name(name)
  portal.organizer = Organizer.find_by_name!('Messe Berlin')
  portal.save!
end

['Fachpack', 'Biofach'].each do |name|
  portal = Portal.find_or_initialize_by_name(name)
  portal.organizer = Organizer.find_by_name!('NürnbergMesse')
  portal.save!  
end

['Cebit'].each do |name|
  portal = Portal.find_or_initialize_by_name(name)
  portal.organizer = Organizer.find_by_name!('Hannover Messe')
  portal.save!  
end

['Wording', 'Frontend', 'Backend'].each do |name|
  Category.find_or_create_by_name(name)
end

['Spelling', 'Inconsistency'].each do |name|
  category = Category.find_or_initialize_by_name(name)
  category.parent = Category.find_by_name!('Wording')
  category.save! 
end

['Redsys'].each do |name|
  category = Category.find_or_initialize_by_name(name)
  category.parent = Category.find_by_name!('Backend')
  category.save! 
end