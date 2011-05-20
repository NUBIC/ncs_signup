Feature: Manage register_participants
  In order to allow people to sign up to be contacted for the NCS
  the NCS group
  wants a form to capture participant information
  
  Scenario: Register new potential participant 
    Given I am on the signup_new page
    When I fill in "Name" with "Sally Sue"
    And I fill in "Address" with "123 Street Ave"
    And I fill in "Apt or unit" with "#123"
    And I fill in "Home phone" with "123-555-1231"
    And I fill in "Mobile phone" with "123-555-1231"
    And I fill in "Work phone" with "123-555-1231"
    And I fill in "Email" with "email 1"
    #And I select "My Home Number" from "Contact Peference"
    And I press "Submit"
    Then I should see "Thanks for submitting your information" within "#content"


