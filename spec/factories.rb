Factory.define :category do |f|
  f.name "General"
end

Factory.define :organizer do |f|
  f.name "Messe Berlin"
end

Factory.define :portal do |f|
  f.name "ITB"
end

Factory.define :ticket do |f|
  f.name "Fehler auf der Plattform"
end

Factory.define :user do |f|
  f.sequence(:username) { |n| "foo#{n}" }
  f.password "secret"
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end