# GIVENS

Given /^an existing party with the following data:$/ do |table|
  # table is a Cucumber::Ast::Table, i.e.,
  # Given I have:
  #   | a | b |
  #   | c | d |
  data = table.raw  # stores [['a', 'b'], ['c', 'd']] in the data variable
  attributes = Hash.new # make a hash to store the attributes
  data.each do |k,v| 
    attributes[k] = v
  end
  @party = @an.parties.create!(attributes)
end

Given /^an existing graduation party$/ do
  @grad = Factory.create(:party, :host => @an, :rsvp_date => nil)
  @daigles = Factory.create(:guest, :name => "Daigle Family", :party => @grad)
end

Given /^an existing birthday party$/ do
  @birthday = Factory.create(:party, :name => "Birthday!", :host => @an)
  @heimann = Factory.create(:guest, :party => @birthday, :name => "Heimann Family", :expected_attendees => 4, :actual_attendees => 4)
  @phelps = Factory.create(:guest, :party => @birthday, :name => "Phelps Family", :expected_attendees => 4, :actual_attendees => 4)
  @quesenberry = Factory.create(:guest, :party => @birthday, :name => "Quesenberry Family", :expected_attendees => 3, :actual_attendees => 2)
  @sooriamurthi = Factory.create(:guest, :party => @birthday, :name => "Sooriamurthi Family", :expected_attendees => 4, :actual_attendees => 3)
  @weinberg = Factory.create(:guest, :party => @birthday, :name => "Weinberg Family", :expected_attendees => 2, :actual_attendees => nil)
  @blazevich = Factory.create(:guest, :party => @birthday, :name => "Blazevich Family")
  @young = Factory.create(:guest, :party => @birthday, :name => "Young Family", :actual_attendees => nil)
  # Expected = 27; Actual = 18; seven families invited; five responses and two no-response-yet
end