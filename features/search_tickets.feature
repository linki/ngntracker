Feature: Search Tickets
  In order to find specific tickets
  As a user
  I want search in the list of public and my own tickets
  
  Background:
    Given I am logged in as "martin"
      And I have the following tickets in the database:
            | name                           | description                  | user_login | published |
            | Fehler auf der Plattform       | Einloggen funktioniert nicht | martin     | true      |
            | Austeller wird nicht angezeigt | Obwohl er freigeschaltet ist | martin     | true      |

    Scenario: See all tickets without search string
       When I go to the tickets page
       Then I should see "Fehler auf der Plattform" within "#tickets"
        And I should see "Austeller wird nicht angezeigt" within "#tickets"

    Scenario: Search in name
      When I go to the tickets page
       And I fill in "Search" with "Fehler"
       And I press "Submit"
      Then I should see "Fehler auf der Plattform" within "#tickets"
       But I should not see "Austeller wird nicht angezeigt"
  
    Scenario: Search in description
      When I go to the tickets page
       And I fill in "Search" with "Einloggen"
       And I press "Submit"
      Then I should see "Fehler auf der Plattform" within "#tickets"
       But I should not see "Austeller wird nicht angezeigt"
