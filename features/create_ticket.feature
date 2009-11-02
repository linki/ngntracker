Feature: Create Ticket
  In order to submit my bug report
  As a user
  I want to create a new ticket
  
  Background:
    Given I am logged in
      And I have the category "General"
    
  Scenario: Create a valid Ticket
    Given I have no tickets in the database
      And I am on the tickets page
     When I follow "Create Ticket"
      And I fill in the following:
            | Name        | Fehler auf der Plattform |
            | Description | Something doesn't work   |
      And I select "General" from "Category"
      And I press "Create Ticket"
     Then I should see "Successfully created ticket." within "#flash_notice"
      And I should see "Fehler auf der Plattform" within "#title"
      And I should have 1 ticket in the database

  Scenario: Can't create an invalid Ticket
    Given I have no tickets in the database
      And I am on the tickets page
     When I follow "Create Ticket"
      And I press "Create Ticket"
     Then I should see "Error while creating ticket." within "#flash_error"
      And I should have no tickets in the database
  
  
  

  
