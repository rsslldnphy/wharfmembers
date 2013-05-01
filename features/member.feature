Feature:
  In order to store membership details
  As a user
  I want to be able to create and edit members

  Background:
    Given I have logged in

  Scenario: Registering a new member
    Given   I am on the new member page
    When    I register a new member
    Then    They appear on the pending registrations page
    But     They do not appear on the current members page
    And     They do not appear on the mailing list page
    And     They do not appear on the expired members page

  Scenario: Autocompletion of registration
    Given   I registered a new member over 48 hours ago
    Then    They appear on the current members page
    And     They do not appear on the pending registrations page
    And     They appear on the mailing list page
    And     They do not appear on the expired members page

  Scenario: Expired
    Given   I registered a member over a year ago
    Then    They appear on the expired members page
    But     They do not appear on the current members page
    And     They do not appear on the pending registrations page

  Scenario: Renew membership
    Given   I registered a member over a year ago
    When    I renew their membership
    Then    They appear on the current members page
    And     They appear on the mailing list page
    But     They do not appear on the expired members page
