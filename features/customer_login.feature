Feature: Customer Log in the website
    As a customer who has already signed up
    I want to login to the website
    So that I can use the Functionalities.

    Scenario: customer login
        Given I have already signed up
        When I click "Login" in button
        Then I should see "Welcome"
