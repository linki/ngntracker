Feature: List Tickets
  In order browse through present tickets
  As a user
  I want to see a list of public and my own tickets
  
  Background:
    Given I am logged in as "martin"
      And I have the following tickets in the database:
            | name                           | user_login | published |
            | Fehler auf der Plattform       | martin     | true      |
            | Austeller wird nicht angezeigt | martin     | false     |
            | Something is really weird      | steffen    | true      |
            | Is this gonna be forever?      | steffen    | false     |

    Scenario: See all my tickets
       When I go to the tickets page
       Then I should see "Fehler auf der Plattform" within "#tickets"
        And I should see "Austeller wird nicht angezeigt" within "#tickets"

    Scenario: See public tickets from others
       When I go to the tickets page
       Then I should see "Something is really weird" within "#tickets"
  
    Scenario: Can't see private tickets
       When I go to the tickets page
       Then I should not see "Is this gonna be forever?" within "#tickets"

    Scenario: Can see private tickets as an admin    