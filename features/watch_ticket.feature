Feature: Watch ticket
  In order to bookmark tickets for tracking
  As a user
  I want to watch tickets and see a list of all my watched tickets
  
  Background:
    Given a user: "martin" exists
    And that user is logged in
    
  Scenario: watch a ticket
    Given a ticket exists
    When I go to that ticket's page
    And I follow "Watch Ticket"
    Then I should see "You are now watching the ticket."
    And user: "martin" should be one of that ticket's watching_users

  Scenario: unwatch a ticket
    Given a ticket exists
    And a watch exists with user: user "martin", ticket: that ticket
    When I go to that ticket's page
    And I follow "Unwatch Ticket"
    Then I should see "You are no longer watching the ticket."
    And user: "martin" should not be one of that ticket's watching_users
  
  Scenario: show watched ticket in watch list
    Given a ticket exists with name: "Fehler auf der Plattform", published_at: "2000-01-01"
    And a watch exists with user: user "martin", ticket: that ticket    
    When I go to my watch list
    Then I should see "Fehler auf der Plattform" within "#tickets"

  Scenario: don't show unwatched ticket in watch list
    Given a ticket exists with name: "Fehler auf der Plattform", published_at: "2000-01-01"
    When I go to my watch list
    Then I should not see "Fehler auf der Plattform"
  
  
  
  

  
