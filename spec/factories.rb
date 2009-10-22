Factory.define :category do |f|
  f.name "General"
end

Factory.define :comment do |f|
  f.text "Hello World"
  f.association :ticket
  f.association :user
end

Factory.define :organizer do |f|
  f.name "Messe Berlin"
end

Factory.define :page do |f|
  f.name "Hilfe"
end

Factory.define :portal do |f|
  f.name "ITB"
end

Factory.define :ticket do |f|
  f.name "Fehler auf der Plattform"
  f.description "Something went wrong somewhere"
  f.association :category
end

Factory.define :user do |f|
  f.sequence(:username) { |n| "foo#{n}" }
  f.password "secret"
  f.password_confirmation { |u| u.password }
  f.sequence(:email) { |n| "foo#{n}@example.com" }
end

Factory.define :visit do |f|
  f.association :user
  f.association :ticket
end

Factory.define :watch do |f|
  f.association :user
  f.association :ticket
end