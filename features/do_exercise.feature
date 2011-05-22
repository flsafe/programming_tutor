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
    And I should see the time remaining for the exercise

  Scenario: The user checks runs thier code through unit tests
    Given I am a user
    And I am doing an exercise
    When I type a program with a syntax error
    And I press the check solution button
    Then I should see a syntax error message
