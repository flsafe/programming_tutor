Feature: A user can register 
  So that I can have an account, and access certain features
  As a user
  I want to be register 

  Scenario: The user attempts to register with correct info
    When I submit correct registration info on the registration page
    Then I should be registered 
    And I should be automatically logged in
