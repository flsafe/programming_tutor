Feature: A user does an exercise 
  So that I can practice my programming skills
  As an user
  I want to do an exercise

  Scenario: The user selects an exercise
    Given I am a user
    And there exists an exercise in the database
    When I am viewing the code page for the exercise
    Then I should see the exercise prototype
    And I should see the exercise text
