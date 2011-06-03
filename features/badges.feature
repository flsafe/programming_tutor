Feature: A user does an exercise and gains experience
  So that I can track my progress 
  As an user
  I want to see my experience increase

  Scenario: User gains experience points from completing an exercise 
    Given I am a user
    And there exists an exercise in the database
    When I complete the exercise
    Then I should have the exercise experience points assigned to me
