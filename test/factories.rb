# FACTORIES FOR PARTY MANAGER 
# -------------------------------
# Create factory for Host class
  Factory.define :host do |h|
    h.first_name "An"
    h.last_name "Heimann"
    h.username { |a| "#{a.first_name}.#{a.last_name}".downcase }
    h.email { |a| "#{a.first_name}.#{a.last_name}@example.com".downcase }
    h.password "fredbar"
    h.password_confirmation { |a| a.password }
  end
  
# Create factory for Party class
  Factory.define :party do |p|
    p.association :host
    p.name "Graduation Party"
    p.party_date 1.month.from_now
    p.rsvp_date 3.weeks.from_now
    p.association :location
    p.association :party_type
    p.start_time "12:00:00"
    p.description "A great and thrilling time will be had by all."
    p.end_time { |a| a.start_time + 3.hours }
  end

# Create factory for Guest class
  Factory.define :guest do |g|
    g.association :host
    g.name "Artis Family"
    g.email "artis5@example.com"
    g.notes "This is the song that runs under the credits..."
  end

# Create factory for Invitation class
  Factory.define :invitation do |i|
    i.association :party
    i.association :guest
    i.invite_code nil
    i.expected_attendees 5
    i.actual_attendees 5
  end

# Create factory for Location class
  Factory.define :location do |l|
    l.association :host
    l.name "My house"
    l.street "10152 Sudberry Drive"
    l.city "Wexford"
    l.state "PA"
    l.zip "15090"
    l.latitude 40.597761
    l.longitude -80.063405
  end
  
# Create factory for PartyType class
  Factory.define :party_type do |pt|
    pt.name "General Party"
    pt.active true
  end
