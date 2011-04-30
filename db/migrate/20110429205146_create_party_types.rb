class CreatePartyTypes < ActiveRecord::Migration
  def self.up
    create_table :party_types do |t|
      t.string :name
      t.boolean :active
      t.timestamps
    end
  end

  def self.down
    drop_table :party_types
  end
end
