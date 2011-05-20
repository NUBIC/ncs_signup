Given /^the following register_participants:$/ do |register_participants|
  RegisterParticipant.create!(register_participants.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) register_participant$/ do |pos|
  visit register_participants_path
  within("table tr:nth-child(#{pos.to_i+1})") do
    click_link "Destroy"
  end
end

Then /^I should see the following register_participants:$/ do |expected_register_participants_table|
  expected_register_participants_table.diff!(tableish('table tr', 'td,th'))
end
