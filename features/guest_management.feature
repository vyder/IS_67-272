Feature: Manage guests
	As a party host
	I want to be able to manage guest invitations
	So I can reduce the overhead of hosting parties

	Background:
	  Given a logged in user
		Given an existing birthday party
	
	# READ METHODS
	Scenario: View my guests
		When I go to my guests page
		Then I should see "My Guests" within "h1"
		And I should see "Party" within "th"
		And I should see "Name"
		And I should see "Expected"
		And I should see "Actual"
		And I should see "Add A New Guest"
		And I should see "Heimann Family"
		And I should see "Phelps Family"
		And I should see "Quesenberry Family"
		And I should see "Birthday!"
	
	Scenario: View guest details
		Given an existing artis family guest
		When I go to this guest details page
		Then I should see "Name: Artis Family"
		And I should see "Expected attendees: 5"	
		And I should see "Actual attendees: 5"
		And I should see "Invite code"
		
	Scenario: Counts on the party page are correct
		When I go to the birthday party details page
		Then I should see "Expected Attendance: 27"
		And I should see "Confirmed Attendance: 18"
		And I should see "Invited Guests"
		And I should see "Heimann Family"
		And I should see "Phelps Family"
		And I should see "Quesenberry Family"
		And I should see "Birthday!"

	# CREATE METHODS
	Scenario: Create a new guest - no actual/confirmed attendees field
		When I go to the new guest page
		Then I should not see actual attendees option

	Scenario: Create a new guest - no invitation code field to be set
		When I go to the new guest page
		Then I should not see invite code option

	Scenario: Create a new guest is successful
		When I go to the new guest page
		And I fill in "guest_name" with "Mansar Family"
		And I fill in "guest_email" with "smansar@example.com"
		And I fill in "guest_expected_attendees" with "4"
		And I select "Birthday!" from "guest_party_id"
		And I press "Create Guest"
		Then I should see "Guest was successfully created"
		And I should see "Invite code"
	
	Scenario: Create a guest fails because of an missing name
		When I go to the new guest page
		And I fill in "guest_email" with "smansar@example.com"
		And I fill in "guest_expected_attendees" with "4"
		And I select "Birthday!" from "guest_party_id"
		And I press "Create Guest"
		Then I should see "Name can't be blank"
	
	Scenario: Create a guest fails because of an invalid email
		When I go to the new guest page
		And I fill in "guest_name" with "Mansar Family"
		And I fill in "guest_email" with "smansar@example,com"
		And I fill in "guest_expected_attendees" with "4"
		And I select "Birthday!" from "guest_party_id"
		And I press "Create Guest"
		Then I should see "Email is not a valid format"
	
	Scenario: Create guest fails b/c of invalid value for expected attendees
		When I go to the new guest page
		And I fill in "guest_name" with "Mansar Family"
		And I fill in "guest_email" with "smansar@example.com"
		And I fill in "guest_expected_attendees" with "four"
		And I select "Birthday!" from "guest_party_id"
		And I press "Create Guest"
		Then I should see "Expected attendees is not a number"
	
	Scenario: Adding 4 expected to a party changes counts and guest list
		When I go to the new guest page
		And I fill in "guest_name" with "Mansar Family"
		And I fill in "guest_email" with "smansar@example.com"
		And I fill in "guest_expected_attendees" with "4"
		And I select "Birthday!" from "guest_party_id"
		And I press "Create Guest"
		And I go to the birthday party details page
		Then I should see "Expected Attendance: 31"
		And I should see "Confirmed Attendance: 18" 
		And I should see "Mansar Family"
	
	
	# UPDATE METHODS
	Scenario: Edit a guest is successful
		Given an existing artis family guest
		When I go to edit this guest page
		And I fill in "guest_expected_attendees" with "4"
		And I press "Update Guest"
		Then I should see "Expected attendees: 4"
		
	Scenario: Edit a guest fails b/c of invalid value for expected attendees
		Given an existing artis family guest
		When I go to edit this guest page
		And I fill in "guest_expected_attendees" with "free fred!"
		And I press "Update Guest"
		Then I should see "Expected attendees is not a number"
		
	Scenario: Edit a guest fails because of an invalid email
		Given an existing artis family guest
		When I go to edit this guest page
		And I fill in "guest_email" with "newartis@example,com"
		And I press "Update Guest"
		Then I should see "Email is not a valid format"
	