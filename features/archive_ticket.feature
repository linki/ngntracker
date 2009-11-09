Feature: Archive ticket
  In order to remove tickets from the list without deleting them
  As an administrator
  I want to archive tickets

  Background:
    Given I am logged in
    
  Scenario: archive a ticket
    Given a ticket exists
    When I go to that ticket's page
    And I follow "Archive Ticket"
    Then I should see "Successfully archived the ticket"
    And the ticket should be archived
    
  Scenario: Don't show archived ticket in list
    Given a ticket exists with name: "Fehler auf der Plattform", archived_at: "2000-01-01", published_at: "2000-01-01"
    When I go to the tickets page
    Then I should not see "Fehler auf der Plattform"
    
  Scenario: Show archived ticket in archive
    Given a ticket exists with name: "Fehler auf der Plattform", archived_at: "2000-01-01", published_at: "2000-01-01"
    When I go to the archive
    Then I should see "Fehler auf der Plattform" within "#tickets"
  
  
  
  
  
  
  
  
  
