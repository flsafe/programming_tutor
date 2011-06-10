Feature: A user does an exercise and gains experience
  So that I can track my progress 
  As an user
  I want to see my experience increase

  Scenario: User gains experience points from completing an exercise 
    Given I am a user
    And I am doing an exercise
    When I type a correct solution
    And I press the check syntax button
    And I press the check solution button
    And I press the submit solution button
    Then I should have the exercise experience points assigned to me
    And I should have my usage statistics updated

  Scenario: User gains a badge 
    Given I am a user
    And there exists an exercise in the database
    And there exists a first exercise badge in the database
    When I complete the exercise
    Then I should have the first exercise badge 
