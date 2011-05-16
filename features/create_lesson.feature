Feature: Create a lesson
  So that users can learn a new programming subject
  As an admin user
  I want to create a new lesson

  Scenario: An admin user creates a new lesson
    Given I am an admin user
    When I create a new lesson
    Then I should see a success message

  Scenario: A regular user creates a new lesson
    Given I am a user
    When I create a new lesson
    Then I should be redirected to the home page 
