Feature: Assign ticket
  In order to make people responsible for open tickets
  As an administrator
  I want to assign someone to a ticket and change ticket's stage to processing
  
  Background:
    Given I am logged in
    
  Scenario: assign somebody to a ticket
    Given a user exists with name: "Martin"
    And a ticket exists with state: "open"
    When I go to that ticket's page
    And I select "Martin" from "Assignee"
    And I press "Assign"
    Then I should see "Successfully assigned the ticket"
    And the user should be the ticket's assignee
    And the ticket should be processing
  
  
  

  
