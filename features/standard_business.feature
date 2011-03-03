Feature: Standard Business
	As a potential user
	I want to be able to view certain information
	So I can have confidence in the system
	
	Scenario: View 'About Us'
		When I go to the About Us page
		Then I should see "About" within "h1"

	Scenario: View 'Contact Us'
		When I go to the Contact Us page
		Then I should see "Contact" within "h1"

	Scenario: View 'Privacy Policy'
		When I go to the Privacy page
		Then I should see "Privacy" within "h1"

	Scenario: View webmaster information in footer
		When I go to the home page
		Then I should see "Webmaster" within "#footer"
	