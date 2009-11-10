Feature: Create Comment
  In order to allow users to add additional information or hints
  As a user
  I want to add comments to tickets

  Background:
    Given I am logged in
    
  Scenario: add a comment to a ticket
    Given no comments exist
    And a ticket exists
    When I go to that ticket's page
    And I fill in "Your Comment" with "Bloody Hell"
    And I press "Create Comment"
    Then I should see "Successfully created your comment."
    And I should be on the ticket's page
    And I should see "Bloody Hell" within "#comments"    
    And a comment should exist with text: "Bloody Hell"