Feature: Manage register_participants
  In order to allow people to sign up to be contacted for the NCS
  the NCS group
  wants a form to capture participant information
  
  Scenario: Register new potential participant 
    Given I am on the signup_new page
    When I fill in "Name *" with "Sally Sue"
    And I fill in "Address" with "123 Street Ave"
    And I fill in "Apt or Unit" with "#123"
    And I fill in "City" with "Chicago"
    And I fill in "State" with "Illinois"
    And I fill in "Zip" with "60611"
    And I fill in "Home phone" with "123-555-1231"
    And I fill in "Mobile phone" with "123-555-1231"
    And I fill in "Work phone" with "123-555-1231"
    And I fill in "E-mail" with "email@somewhere.com"
    And I select "Call me" from "Preferred way to contact you?"
    And I press "Submit"
    Then I should see "Thanks for submitting your information!" within "#thank_you"


   Scenario: Participant does not give all required fields - no name
    Given I am on the signup_new page
    When I fill in "Home phone *" with "123-555-1231"
    And I press "Submit"
    Then I should see "Please provide your first and last name" within "#flashmsg"

   Scenario: Participant does not give all required fields - no phone
    Given I am on the signup_new page
    When I fill in "Name *" with "Bob Smith"
    And I press "Submit"
    Then I should see "Please provide at least one phone number" within "#flashmsg"

   Scenario: Participant gives all required fields but bad email
    Given I am on the signup_new page
    When I fill in "Name *" with "Bob Smith"
    When I fill in "Home phone *" with "123-555-1234"
    When I fill in "E-mail" with "bademail"
    And I press "Submit"
    Then I should see "E-mail needs to be in the correct format" within "#flashmsg"

