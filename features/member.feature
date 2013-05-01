Feature:
  In order to store membership details
  As a user
  I want to be able to create and edit members

  Background:
    Given I have logged in

  Scenario: Registering a new member
    Given   I am on the new member page
    When    I register a new member
    Then    they appear on the pending registrations page

  Scenario: Autocompletion of registration
    Given   I registered a new member over 48 hours ago
    Then    they appear on the current members page

  Scenario: Renewal of membership
    Given   I registered a member over a year ago
    When    I renew their membership
    Then    they appear on the current members page

  Scenario: Pending members
    Given   I have registered a member in the last 48 hours
    Then    they do not appear on the mailing list page
    And     they do not appear on the current members page
    And     they do not appear on the expired members page

  Scenario: Current members
    Given   I registered a new member over 48 hours ago
    Then    they appear on the mailing list page
    But     they do not appear on the pending registrations page
    And     they do not appear on the expired members page

  Scenario: Expired members
    Given   I registered a member over a year ago
    Then    they appear on the expired members page
    But     they do not appear on the current members page
    And     they do not appear on the pending registrations page

  Scenario: Renewed members
    Given   I have renewed a member's membership
    Then    they appear on the current members page
    And     they appear on the mailing list page
    But     they do not appear on the expired members page
    And     they do not appear on the pending registrations page

