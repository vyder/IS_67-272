class AddDefaultHost < ActiveRecord::Migration
  def self.up
		default = Host.new

		default.first_name = "Vidur"
		default.last_name = "Murali"
		default.username = "Vidur"
		default.email = "vidur.murali@gmail.com"
		default.password = "secret"
		default.password_confirmation = "secret"

		default.save!
  end

  def self.down
		default = Host.where("username = ?", "Vidur").first
		Host.delete	default
  end
end
