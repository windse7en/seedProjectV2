Feature: Customer Forget Password
    As I have already signed up
    In order to modify password
    So that I can get the reset password email

    Scenario: Customer use email to reset the forgot password
        Given I have already signed up
        When I click "Forgot your password"
        Then I should see "Forgot password"
        And I should see "user_email" input
