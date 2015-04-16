Given(/^I am not signed up before$/) do
end

When(/^I visit sign up the website$/) do
  visit new_user_registration_path
end

Then(/^I should see "(.*?)"$/) do |words|
    # pending # express the regexp above with the code you wish you had
  page.should have_content(words)
end

Then(/^I should see "(.*?)" input$/) do |arg1|
  #  pending # express the regexp above with the code you wish you had
  find_field arg1
end

Given(/^I have already signed up$/) do
  customer = FactoryGirl.create(:user)
end

When(/^I click "(\w+)" in button$/) do |button_title|
  #  peding # express the regexp above with the code you wish you had
  visit root_path
  fill_in "user_email", with: "test@test.com"
  fill_in "user_password", with: "password"
  click_button button_title
end

When(/^I click "(.*?)"$/) do |arg1|
    #pending # express the regexp above with the code you wish you had
  visit root_path
  click_link arg1
end

