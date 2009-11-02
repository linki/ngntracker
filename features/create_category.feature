Feature: Create Category
  In order to categorize and manage tickets
  As a user
  I want to create new categories
  
  Background:
    Given I am logged in
    
  Scenario: Create a category
    Given I have no categories in the database
      And I am on the categories page
     When I follow "Create Category"
      And I fill in "Name" with "General"
      And I press "Create Category"
     Then I should see "Successfully created category." within "#flash_notice"
      And I should see "General" within "#title"
      And I should have 1 category in the database  

  Scenario: Create a child category
    Given I have the category "General"
      And I am on the categories page
     When I follow "Create Category"
      And I fill in "Name" with "Special"
      And I select "General" from "Parent"
      And I press "Create Category"
     Then I should see "Successfully created category." within "#flash_notice"
      And I should see "Special" within "#title"
      And I should see "General" within "#parent"
      And I should have 2 categories in the database  
  
  

  
