class CreatePortals < ActiveRecord::Migration
  def self.up
    create_table :portals do |t|
      t.string :name
      t.string :uri
      t.timestamps
    end
  end
  
  def self.down
    drop_table :portals
  end
end
