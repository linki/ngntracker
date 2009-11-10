Feature: Register
  In order to allow users to access the internal area
  As a guest
  I want to register by submitting my email and later registrating on the plattform (also eligable for anonymous ticket creation)

  Scenario: submit email and receive message
    Given no users exist
    When I go to the signup page
    And I fill in "Email" with "foo@bar.com"
    And I press "Submit"
    Then I should see "Check your emails for your registration code." within "#flash_notice"
    And 1 email should be delivered to foo@bar.com
    And that email should have subject: "Your Registration Code"
    And a user should exist with email: "foo@bar.com"

  Scenario: sign up with registration code
    Given a user: "martin" exists
    When I go to the signup page
    And I fill in "Registration Token" with user: "martin"'s perishable_token
    And I fill in "Name" with "Foobar"
    And I fill in "Login" with "foobar"
    And I fill in "Email" with "foo@bar.com"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I press "Submit"
    Then I should see "Successfully registered your account." within "#flash_notice"
    And a user should exist with name: "Foobar"

  Scenario: reject wrong email
    Given no users exist
    When I go to the signup page
    And I fill in "Email" with "foo"
    And I press "Submit"
    Then I should not see "Check your emails for your registration code."
    And 0 emails should be delivered to foo@bar.com
    And a user should not exist

  Scenario: reject sign up with invalid registration code
    Given a user: "martin" exists
    When I go to the signup page
    And I fill in "Registration Token" with "wrong"
    And I fill in "Name" with "Foobar"
    And I fill in "Login" with "foobar"
    And I fill in "Email" with "foo@bar.com"
    And I fill in "Password" with "secret"
    And I fill in "Password Confirmation" with "secret"
    And I press "Submit"
    Then I should not see "Successfully registered your account."
    And a user should not exist with name: "Foobar"
    
  
  
  
  
  
  
