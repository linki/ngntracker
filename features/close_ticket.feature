Feature: Close ticket
  In order to complete a ticket
  As an administrator
  I want to close a ticket
  
  Background:
    Given I am logged in
    
  Scenario: close an open ticket
    Given a ticket exists
    When I go to that ticket's page
    And I follow "Close Ticket"
    Then I should see "Successfully closed the ticket"
    And the ticket should be closed
  
  
  

  
