class CreateGuests < ActiveRecord::Migration
  def self.up
    create_table :guests do |t|
      t.string :name
      t.string :email
      t.string :invite_code
			t.integer :party_id
      t.integer :expected_attendees
      t.integer :actual_attendees
      t.timestamps
    end
  end

  def self.down
    drop_table :guests
  end
end
