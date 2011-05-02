# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

hosts = Host.create([{ :first_name => 'Vidur', :last_name => 'Murali',
												:username => 'Vidur', :email => 'vidur.murali@gmail.com', 
												:password => 'secret', :password_confirmation => 'secret' }])
