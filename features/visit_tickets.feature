Feature: Visit Tickets
  In order to see changed tickets
  As a user
  I want to see new and old tickets
  
  Background:
    Given I am logged in
  
  Scenario: An not yet visited ticket is new
    Given I have the ticket "Fehler auf der Plattform"
      And the ticket "Fehler auf der Plattform" is published
     When I go to the tickets page
     Then I should see "new"
  
  Scenario: A visted tickets is not new
    Given I have the ticket "Fehler auf der Plattform"
      And the ticket "Fehler auf der Plattform" is published    
     When I go to the tickets page
      And I follow "Fehler auf der Plattform"
      And I follow "Back"
     Then I should not see "new"
