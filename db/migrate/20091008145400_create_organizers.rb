class CreateOrganizers < ActiveRecord::Migration
  def self.up
    create_table :organizers do |t|
      t.string :name
      t.timestamps
    end
  end
  
  def self.down
    drop_table :organizers
  end
end
