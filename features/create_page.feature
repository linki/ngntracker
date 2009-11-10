Feature: Create page
  In order to put additional content on the portal
  As an administrator
  I want to create new pages
  
  Background:
    Given I am logged in

  Scenario: create page
    Given no pages exist
    And I am on the pages page
    When I follow "Create Page"
    And I fill in the following:
        | Name | Help |
    And I press "Create Page"
    Then I should see "Successfully created the page." within "#flash_notice"
    And I should see "Help" within "#title"
    And a page exists with name: "Help"
  
  
  

  
