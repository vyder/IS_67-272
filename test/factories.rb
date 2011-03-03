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
    p.location "My house"
    p.start_time "12:00:00"
    p.end_time { |a| a.start_time + 3.hours }
  end

# Create factory for Guest class
  Factory.define :guest do |g|
    g.association :party
    g.name "Artis Family"
    g.email "artis5@example.com"
    g.invite_code "tqbFjotlD"
    g.expected_attendees 5
    g.actual_attendees 5
  end
