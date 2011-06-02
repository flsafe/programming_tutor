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

  Scenario: The user has a syntax error
    Given I am a user
    And I am doing an exercise
    When I type a program with a syntax error
    And I press the check syntax button
    Then I should see a syntax error message

  Scenario: The user doesn't have a syntax error
    Given I am a user
    And I am doing an exercise
    When I type a program without a syntax error 
    And I press the check syntax button
    Then I should not see a syntax error message

  Scenario: The user wants to run unit tests without submitting 
    Given I am a user
    And I am doing an exercise
    When I type a correct solution 
    And I press the check solution button 
    Then I should see an 'ok' message 

  Scenario: Submits thier solution for a grade 
    Given I am a user
    And I am doing an exercise
    When I type a correct solution 
    And I press the submit solution button 
    Then I should see a grade sheet with a perfect grade
    And I should see my src code
