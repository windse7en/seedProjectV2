Feature: customer sign up
    As a customer
    I want to sign up the web site
    So that I can login in to it
    Scenario: sign up
        Given I am not signed up before
        When I sign up the website
        Then the website should say "Sign Up"
        And the website should say "Email"
        And the website should say "Password"
