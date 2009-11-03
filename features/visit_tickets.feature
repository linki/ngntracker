Feature: Visit Tickets
  In order to see changed tickets
  As a user
  I want to see new and old tickets
  
  Background:
    Given I am logged in
  
  Scenario: Mark new tickets
    Given I have the ticket "Fehler auf der Plattform"
      And the ticket "Fehler auf der Plattform" is published
     When I go to the list of tickets
     Then I should see "new"
  
  Scenario: Do not mark old tickets
    Given I have the ticket "Fehler auf der Plattform"
      And the ticket "Fehler auf der Plattform" is published    
     When I go to the list of tickets
      And I follow "Fehler auf der Plattform"
      And I follow "Back"
     Then I should not see "new"
