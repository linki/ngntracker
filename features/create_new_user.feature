Feature: Create New User
  In order to allow users to see public tickets
  As an admin
  I want to create a new user

  Scenario: Create a valid User
    Given I have no users in the database
      And I am on the users page
     When I follow "Create User"
      And I fill in the following:
            | Name                  | John Doe    |
            | Login                 | johnny      |            
            | Email                 | foo@bar.com |
            | Password              | foobar      |
            | Password Confirmation | foobar      |
      And I press "Create User"
     Then I should see "Successfully created user." within "#flash_notice"
      And I should see "John Doe" within "#title"
      And I should have 1 user in the database