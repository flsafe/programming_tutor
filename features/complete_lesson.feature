Feature: A user browses and completes a lesson
  So that I can practice my programming skills
  As a user
  I want to complete lessons

  Scenario: A regular user browses a lesson
    Given I am a user
    And there exists a lesson in the database
    When I select a lesson to complete
    Then I should see the lesson text
    And I should see the associated exercises
