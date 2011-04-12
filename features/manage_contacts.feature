@contacts
Feature: Contacts
  In order to have contacts on my website
  As an administrator
  I want to manage contacts

  Background:
    Given I am a logged in refinery user
    And I have no contacts

  @contacts-list @list
  Scenario: Contacts List
   Given I have contacts titled Alexander, Zack Boom
   When I go to the list of contacts
   Then I should see "Alexander"
   And I should see "Zack Boom"

  @contacts-valid @valid
  Scenario: Create Valid Contact
    When I go to the list of contacts
    And I follow "Add New Contact"
    And I fill in "Last Name" with "Doe"
    And I press "Save"
    Then I should be on the list of contacts
    And I should see "'Doe' was successfully added."
    And I should have 1 contact
    And the contact created_by field should belongs to me

  @contacts-invalid @invalid
  Scenario: Create Invalid Contact (without first_name)
    When I go to the list of contacts
    And I follow "Add New Contact"
    And I press "Save"
    Then I should see "Last Name can't be blank"
    And I should have 0 contacts

  @contacts-edit @edit
  Scenario: Edit Existing Contact
    Given I have contacts titled "Doe"
    When I go to the list of contacts
    And I follow "Edit this contact" within ".actions"
    Then I fill in "Last Name" with "Walter"
    And I press "Save"
    Then I should see "'Walter' was successfully updated."
    And I should be on the list of contacts
    And I should not see "Doe"
    And the contact updated_by field should belongs to me

  @contacts-delete @delete
  Scenario: Delete Contact
    Given I only have contacts titled Doe
    When I go to the list of contacts
    And I follow "Remove this contact forever"
    Then I should see "'Doe' was successfully removed."
    And I should have 0 contacts
    
  @contacts-tag @tags
  Scenario: The contact new/edit form has tag_list
    When I am on the new contact form
    Then I should see "Tags"
  
  @contacts-tag @tags 
  Scenario: The contact new/edit form saves tag_list
    When I am on the new contact form
    And I fill in "Last Name" with "Doe"
    And I fill in "Tags" with "customer, frontend"
    And I press "Save"

    Then I should have 1 contact
    And the contact should have the tags "customer, frontend"
    
  @contacts-tag @tags
  Scenario: Contact list can be filtered by tag
    Given there is a contact titled "Zack Boom" and tagged "Berlin"
    And there is a contact titled "Alexander" and tagged "Erfurt"
    When I go to the list of contacts tagged with "Erfurt"
    Then I should see "Erfurt"
    And I should see "Alexander"
    And I should not see "Zack Boom"
    
  @contacts-note @notes
  Scenario: Notes can be assigned to contacts
    Given I only have contacts titled John
    When I go to the contact detail of "John"
    And I fill in "Add note to" with "John is cool"
    And I press "Create Note"
    Then I should see "John is cool"
    