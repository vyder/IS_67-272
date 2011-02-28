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
    [Host, Party, Guest].each(&:delete_all)
    
    
    # Step 1: Add some hosts to the system
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
      
      # Step 2: add 2 to 12 parties per host
      Party.populate 2..12 do |party|
        party.host_id = host.id
        party.name = ["Graduation 2011", "Birthday Party", "Cast Party", "TGIF!", "St. Patrick's Day", "Christmas", "First Day of Spring", "FRED Day!", "Super Bowl Party", "Baby Shower", "Wedding Shower", "Boys Night Out", "Pirate Party", "Toga Party", "Frat Party", "End of School Party", "New Year's Eve", "Family Reunion", "Picnic", "Euchre Party"]
        party.location = "#{Faker::Address.city}, #{Faker::Address.us_state_abbr}"
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
        
        # Step 3: add 10 to 50 guests per party (if there are any guests yet...)
        no_guest = rand(10)
        unless no_guest.zero?
          Guest.populate 4..25 do |guest|
            guest.party_id = party.id
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
            guest.invite_code = rand(10 ** 10).to_s.rjust(10,'0')
            guest.expected_attendees = [2,3,4,5,6]
            unless party.rsvp_date.nil?
              not_confirmed = rand(7)
              if not_confirmed.zero?
                guest.actual_attendees = nil
              else
                guest.actual_attendees = [guest.expected_attendees, guest.expected_attendees-1]
              end
            end
            guest.created_at = Time.now
            guest.updated_at = Time.now
          end
        end     
      end
    end
  end
end