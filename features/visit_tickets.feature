Feature: Visit Tickets
  In order to see changed tickets
  As a user
  I want to see new and old tickets
  
  Background:
    Given I am logged in
  
  Scenario: A not yet visited ticket is new
    Given a ticket exists with name: "Fehler auf der Plattform", published_at: "2000-01-01"
    When I go to the tickets page
    Then I should see "new"
  
  Scenario: A visted tickets is not new
    Given a ticket exists with name: "Fehler auf der Plattform", published_at: "2000-01-01"
    When I go to that ticket's page
    And I follow "Back to list"
    Then I should not see "new"
