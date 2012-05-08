class ChangeNotesToText < ActiveRecord::Migration
  def change
    change_column :guests, :notes, :text
  end
end