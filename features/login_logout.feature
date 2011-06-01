Feature: A user can login and logout
  So that I can have an account, and access certain features
  As a user
  I want to be able to login and logout
  @wip
  Scenario: The user attempts to login with incorrect credentials
    Given there exists a user in the database
    And I am not logged in
    When I go to the login page
    And enter an incorrect username and password
    Then I should see a generic error message

      @wip
  Scenario: The user logs in
    Given there exists a user in the database
    And I am not logged in
    When I go to the login page
    And enter a correct username and password
    And I should be redirected to the account page
    And I should see a login notification

  @wip
  Scenario: The user logs out
    Given there exists a user in the database
    And I am a user
    When I click log out
    Then I should be redirected to the home page
    And I should see a logout notification