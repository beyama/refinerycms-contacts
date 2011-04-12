require 'spec_helper'

describe Contact do

  def reset_contact(options = {})
    @valid_attributes = {
      :last_name => "RSpec is great for testing too"
    }

    @contact.destroy if @contact
    @contact = Contact.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_contact
  end

  context "validations" do
    
    it "rejects empty last_name on natural persons" do
      Contact.new(@valid_attributes.merge(:last_name => "")).should_not be_valid
    end
    
    it "rejects empty organisation on organisations" do
      Contact.new(@valid_attributes.merge(:organisation => "", :is_organisation => true)).should_not be_valid
    end
    
  end

  context "virtual attributes" do
    
    it "name returns organisation if is_organisation is true" do
      contact = Contact.new(@valid_attributes.merge(:organisation => 'beyama', :first_name => 'zackboom', :last_name => "Doe", :middle_name => "unknown", :is_organisation => true))
      contact.name.should == "beyama"
    end
    
    it "name returns last_name, first_name and middle_name joined with a space if is_organisation is false" do
      contact = Contact.new(@valid_attributes.merge(:first_name => 'John', :last_name => "Doe", :middle_name => nil, :is_organisation => false))
      contact.name.should == "Doe John"
      contact.middle_name = "unknown"
      contact.name.should == "Doe John unknown"
    end
    
    it "contact_person returns last_name, first_name and middle_name joined with a space" do
      contact = Contact.new(@valid_attributes.merge(:first_name => 'John', :last_name => "Doe", :middle_name => 'Kenna'))
      contact.contact_person.should == "Doe John Kenna"
    end
    
  end
  
  context "protected attributes" do
    
    it "should not mass assign created_by and updated_by ids" do
      contact = Contact.new(@valid_attributes.merge(:created_by_id => 1, :updated_by_id => 1))
      contact.created_by_id.should == nil
      contact.updated_by_id.should == nil
    end
    
  end
  
  context "scopes" do
    
    it "default scope should not return hidden contacts" do
      reset_contact(:hidden => true)
      Contact.count.should == 0
    end
    
  end

end