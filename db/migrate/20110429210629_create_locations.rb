class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :name
			t.integer :host_id
      t.string :street
      t.string :city
      t.string :state
      t.integer :zip
      t.string :latitude
      t.string :longitude
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
