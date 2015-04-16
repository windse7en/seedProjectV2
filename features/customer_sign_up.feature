Feature: customer sign up
    As a customer
    I want to sign up the web site
    So that I can login in to it
    Scenario: sign up
        Given I am not signed up before
        When I visit sign up the website
        Then I should see "Register"
        And I should see "user_email" input
        And I should see "user_password" input
