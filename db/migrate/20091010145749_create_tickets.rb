class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.string :name
      t.text :description
      t.text :solution
      t.string :state
      t.integer :priority
      t.string :direct_link
      t.integer :mantis_bug
      t.integer :category_id
      t.integer :user_id
      t.integer :organizer_id
      t.integer :portal_id
      t.datetime :deadline_at
      t.datetime :published_at
      t.datetime :closed_at
      t.datetime :archived_at
      t.datetime :deleted_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :tickets
  end
end
