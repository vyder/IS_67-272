namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Need two gems to make this work: faker & populator
    # Docs at: http://populator.rubyforge.org/
    require 'populator'
    # Docs at: http://faker.rubyforge.org/rdoc/
    require 'faker'
    
    # Step 0: clear any old data in the db
    [Host, Party, Guest, Location, Invitation, PartyType].each(&:delete_all)
    
    # Step 1: Add some party types to the system
    party_types = %w[Baby\ Shower Birthday General\ Party Graduation Holiday]
    party_types.sort.each do |pt_name|
      # create an PartyType object and assign the name passed into block
      a = PartyType.new
      a.name = pt_name
      # save with bang (!) so exception is thrown on failure
      a.save!
    end
    
    
    # Step 2: Add some hosts to the system
    Host.populate 12 do |host|
      # get some fake data using the Faker gem
      host.first_name = Faker::Name.first_name
      host.last_name = Faker::Name.last_name
      host.email = "#{host.first_name.downcase}.#{host.last_name.downcase}@example.com"
      host.username = "#{host.first_name.downcase}.#{host.last_name.downcase}"
      # password is 'secret'
      host.password_hash = "$2a$10$F62Nx0dpLdijYKPD/WXn9OkNsOsPXzQmCHpVV39bHawJ2IzzVGCaa"
      host.password_salt = "$2a$10$F62Nx0dpLdijYKPD/WXn9O"
      host.created_at = Time.now
      host.updated_at = Time.now
      
      # Step 2A: Add some guests for this host
      Guest.populate 15..25 do |guest|
        guest.host_id = host.id
        # set the guest name string (long, but not hard...)
        male_first_name = %w[Larry Carl Tim Tom Evan Charles John Kevin Joseph Christopher Conrad Blake Greg David Peter Jacob Stafford Ari Ashton Arvind Daniel Lyle Kyle Michael Mitchell Douglas].rand
        female_first_name = %w[Anne Cindy Jeria Sharon Kathy Betsy Beth Katy Deb Valerie Jane Diane Elizabeth Karen Mary Nancy Nicole Angie Ann Amy Samantha Patrica Rachel Kelly].rand
        last_name = Faker::Name.last_name
        is_single = rand(4)
        is_female = rand(2)
        use_family = rand(3)
        if is_single.zero?
          if is_female.zero?
            guest.name = "Ms. #{female_first_name} #{last_name} & Guests"
          else
            guest.name = "Mr. #{male_first_name} #{last_name} & Guests"
          end
        else
          if use_family.zero?
            guest.name = "The #{last_name} Family"
          else
            guest.name = "Mr. & Mrs. #{male_first_name} #{last_name}"
          end
        end
        guest.email = "#{last_name.downcase}#{(1..999).to_a.rand}@example.com"
        guest.notes = Populator.sentences(1..3)
        guest.created_at = Time.now
        guest.updated_at = Time.now
      end
      
      # Step 2B: Add some locations to hold parties at
      locations = {"Carnegie Mellon" => "5000 Forbes Avenue;15213", "Convention Center" => "1000 Fort Duquesne Blvd;15222", "Point State Park" => "101 Commonwealth Place;15222"}
      locations.each do |location|
        loc = Location.new
        loc.host_id = host.id
        loc.name = location[0]
        street, zip = location[1].split(";")
        loc.street = street
        loc.city = "Pittsburgh"
        loc.state = "PA"
        loc.zip = zip
        loc.save!
        sleep(3)  # necessary because of limits imposed by Google on free accounts
      end
    end
        
    # Step 3: add 2 to 12 parties per host
    Host.all.each do |host|
#			guests = host.guests
#     guest_ids = guests.map{|g| g.id}

      guest_ids = Guest.for_host(host.id).all.map{|g| g.id}
      loc_ids = Location.for_host(host.id).all.map{|loc| loc.id}
      Party.populate 2..12 do |party|
        party.host_id = host.id
        party_options = {"Graduation 2011" => 4, "Birthday Party" => 2, "Cast Party" => 3, "TGIF!" => 3, "St. Patrick's Day" => 5, "Christmas" => 5, "First Day of Spring" => 3, "FRED Day!" => 3, "Super Bowl Party" => 3, "Baby Shower" => 1, "Boys Night Out" => 3, "Toga Party" => 3, "Frat Party" => 3, "New Year's Eve" => 5, "Family Reunion" => 3}
        event = party_options.sort_by{ rand }.first
        party.name = event[0]
        party.party_type_id = event[1]
        party.location_id = loc_ids
        party.party_date = 1.week.from_now..12.weeks.from_now
        party.start_time = ["2011-01-01 12:00:00","2011-01-01 15:00:00","2011-01-01 18:00:00","2011-01-01 19:30:00","2011-01-01 21:00:00"]
        party.end_time = party.start_time.to_time + 3.hours
        party.description = Populator.sentences(2..10)
        no_rsvp = rand(6)
        unless no_rsvp.zero?
          party.rsvp_date = party.party_date - 1.day
        end
        # set the timestamps
        party.created_at = Time.now
        party.updated_at = Time.now   
      
        # Step 3A: add 10 to 50 invitations per party (if there are any guests yet...)
        no_invitations = rand(10)
        unless no_invitations.zero?
          possible_guests = guest_ids.sort_by{rand}
          Invitation.populate 5..12 do |invitation|
            invitation.party_id = party.id
            invitation.guest_id = possible_guests.shift
            invitation.invite_code = rand(36**16).to_s(36)
            invitation.expected_attendees = [2,3,4,5,6]
            unless party.rsvp_date.nil?
              not_confirmed = rand(7)
              if not_confirmed.zero?
                 invitation.actual_attendees = nil
              else
                 invitation.actual_attendees = [invitation.expected_attendees, invitation.expected_attendees-1]
              end
            end
            invitation.created_at = Time.now
            invitation.updated_at = Time.now
          end
        end
      end
    end
  end
end      
