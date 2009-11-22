Feature: Reopen ticket
  In order to process an old ticket
  As an administrator
  I want to reopen a ticket
  
  Background:
    Given I am logged in
    
  Scenario: reopen a close ticket
    Given a ticket exists with state: "closed"
    When I go to that ticket's page
    And I follow "Reopen Ticket"
    Then I should see "Successfully reopend the ticket"
    And the ticket should be open
  
  
  

  
