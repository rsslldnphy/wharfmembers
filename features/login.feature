Feature:
  In order to use the app
  As a user
  I want to be able to log in

  Scenario: Not logged in
    When    I visit a page
    Then    I am asked to log in

  Scenario: Logging in
    Given   I am on the sign up page
    When    I fill in my email and password
    Then    I am logged in

  Scenario: Logging out
    Given   I have logged in
    When    I choose to log out
    Then    I am taken back to the login page
