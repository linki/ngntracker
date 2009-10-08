class AddOrganizerIdToPortal < ActiveRecord::Migration
  def self.up
    add_column :portals, :organizer_id, :integer
  end

  def self.down
    remove_column :portals, :organizer_id
  end
end
