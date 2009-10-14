class CreateVisits < ActiveRecord::Migration
  def self.up
    create_table :visits do |t|
      t.integer :user_id
      t.integer :ticket_id
      t.integer :count, :default => 0
      t.timestamps
    end
  end
  
  def self.down
    drop_table :visits
  end
end
