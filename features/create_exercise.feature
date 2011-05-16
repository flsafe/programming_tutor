
Feature: Create an exercise
  So that users can learn test how well they learned the subject in a lesson
  As an admin user
  I want to create a new exercise 

  Scenario: An admin user creates a new lesson
    Given I am an admin user
    When I create a new exercise 
    Then I should see a success message

  Scenario: A regular user creates a new lesson
    Given I am a user
    When I create a new exercise
    Then I should be redirected to the home page
