@contacts-frontend
Feature: Show contacts on frontend
  In order to show contact information on the frontend
  As an website visitor
  I want to list contacts only when there are tagged for the frontend
  
  Background:
    Given only the following contacts
      | first_name | tag_list |
      | Zack Boom  | Berlin   |
      | Alexander  | Erfurt   |
      | Stefan     | Halle    |
    And A simple contacts page exists
    And A Refinery user exists
  
  Scenario: Show only contacts tagged for the frontend
    Given the tags "Berlin, Halle" are released to frontend
    When I go to the contacts frontend list
    Then I should see "Zack Boom"
    Then I should see "Stefan"
    Then I should not see "Alexander"
    
  Scenario Outline: Only show details from contacts tagged for frontend
    Given the tags "Berlin, Halle" are released to frontend
    
    When I go to the contact frontend details of "<contact>"
    Then I should <action> "<contact>"
    
    Examples:
      | contact   | action  |
      | Zack Boom | see     |
      | Stefan    | see     |
      | Alexander | not see |
