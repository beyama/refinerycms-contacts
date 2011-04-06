Given /^I have no contacts$/ do
  Contact.delete_all
end

Given /^I (only )?have contacts titled "?([^\"]*)"?$/ do |only, titles|
  Contact.delete_all if only
  titles.split(', ').each do |title|
    Contact.create(:first_name => title)
  end
end

Given /^there is a contact titled "([^"]*)" and tagged "([^"]*)"$/ do |name, tag|
  Contact.create(:first_name => name, :tag_list => tag)
end

Then /^the contact should have the tags "([^"]*)"$/ do |tag_list|
  Contact.last.tag_list == tag_list.split(', ')
end

Then /^I should have ([0-9]+) contacts?$/ do |count|
  Contact.count.should == count.to_i
end

Then /^the contact (created_by|updated_by) field should belongs to me$/ do |field|
  Contact.last.send(field).login == User.last.login
end

Given /^(only )?the following contacts$/ do |only, table|
  Contact.delete_all if only
  table.hashes.each do |hash|
    Contact.create(hash)
  end
end

Given /^the tags "([^"]*)" are released to frontend$/ do |tags|
  Contact::FRONTEND_TAGS.clear
  Contact::FRONTEND_TAGS << tags.split(', ')
  Contact::FRONTEND_TAGS.flatten!
end

Given /A simple contacts page exists/ do
  page = Page.create(
    :title => "Contacts", :link_url => "/contacts", :deletable => false,
    :position => ((Page.maximum(:position, :conditions => {:parent_id => nil}) || -1)+1),
    :menu_match => "^/contacts?(\/|\/.+?|)$"
  )
end