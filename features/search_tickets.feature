Feature: Search Tickets
  In order to find specific tickets
  As a user
  I want search in the list of public and my own tickets
  
  Background:
    Given I am logged in

    Scenario: See all tickets without search string
      Given a ticket exists with name: "Fehler auf der Plattform", published_at: "2000-01-01"
      When I go to the tickets page
      Then I should see "Fehler auf der Plattform" within "#tickets"

    Scenario: Search in name
      Given a ticket exists with name: "Fehler auf der Plattform", published_at: "2000-01-01"
      And a ticket exists with name: "Aussteller wird nicht angezeigt", published_at: "2000-01-01"
      When I go to the tickets page      
      And I fill in "Search" with "Fehler"
      And I press "Submit"
      Then I should see "Fehler auf der Plattform" within "#tickets"
      But I should not see "Austeller wird nicht angezeigt"
  
    Scenario: Search in description
      Given a ticket exists with name: "Fehler auf der Plattform", description: "Einloggen funktioniert nicht", published_at: "2000-01-01"
      And a ticket exists with name: "Aussteller wird nicht angezeigt", description: "Obwohl er freigeschaltet ist", published_at: "2000-01-01"
      When I go to the tickets page
      And I fill in "Search" with "Einloggen"
      And I press "Submit"
      Then I should see "Fehler auf der Plattform" within "#tickets"
      But I should not see "Austeller wird nicht angezeigt"
      
    Scenario: Search in category name with category select
      Given a category exists with name: "General"
      And a ticket exists with name: "Fehler auf der Plattform", category: that category, published_at: "2000-01-01"
      And a ticket exists with name: "Aussteller wird nicht angezeigt", category: that category, published_at: "2000-01-01"
      When I go to the tickets page
      And I select "General" from "Category"
      And I press "Submit"
      Then I should see "Fehler auf der Plattform" within "#tickets"
      But I should not see "Austeller wird nicht angezeigt"      