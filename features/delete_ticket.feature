Feature: Delete ticket
  In order to remove tickets from the list
  As an administrator
  I want to delete tickets and send them to the recycle bin
  
  Background:
    Given I am logged in
    
  Scenario: delete a ticket
    Given a ticket exists
    When I go to that ticket's page
    And I follow "Delete Ticket"
    Then I should see "Successfully deleted the ticket."
    And the ticket should be deleted

  Scenario: don't show deleted ticket in list
    Given a ticket exists with name: "Fehler auf der Plattform", deleted_at: "2000-01-01", published_at: "2000-01-01"
    When I go to the tickets page
    Then I should not see "Fehler auf der Plattform"
    
  Scenario: show deleted ticket in recycle bin
    Given a ticket exists with name: "Fehler auf der Plattform", deleted_at: "2000-01-01", published_at: "2000-01-01"
    When I go to the recycle bin
    Then I should see "Fehler auf der Plattform" within "#tickets"