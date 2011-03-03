# GIVENS

Given /^a valid user$/ do
  @an = Factory.create(:host)
end

Given /^a logged in user$/ do
  Given "a valid user"
  visit login_url
  fill_in "Username", :with => "an.heimann"
  fill_in "Password", :with => "fredbar"
  click_button "Log in"
end
