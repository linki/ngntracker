Feature: Create User
  In order to allow users to see public tickets
  As an admin
  I want to create a new user
  
  Background:
    Given I am logged in

  Scenario: Create a valid User
    When I go to the users page
    And I follow "Create User"
    And I fill in the following:
            | Name                  | John Doe    |
            | Login                 | johnny      |            
            | Email                 | foo@bar.com |
            | Password              | foobar      |
            | Password Confirmation | foobar      |
    And I press "Create User"
    Then I should see "Successfully created user." within "#flash_notice"
    And 1 email should be delivered to foo@bar.com
    And that email should have subject: "Successfully Registered"
    And I should see "John Doe" within "#title"
    And a user should exist with name: "John Doe", login: "johnny", email: "foo@bar.com"