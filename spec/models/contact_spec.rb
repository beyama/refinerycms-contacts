require 'spec_helper'

describe Contact do

  def reset_contact(options = {})
    @valid_attributes = {
      :id => 1,
      :first_name => "RSpec is great for testing too"
    }

    @contact.destroy! if @contact
    @contact = Contact.create!(@valid_attributes.update(options))
  end

  before(:each) do
    reset_contact
  end

  context "validations" do
    
    it "rejects empty first_name" do
      Contact.new(@valid_attributes.merge(:first_name => "")).should_not be_valid
    end

    it "rejects non unique first_name in scope of last_name, middle_name and company" do
      # as one gets created before each spec by reset_contact
      Contact.new(@valid_attributes).should_not be_valid
      
      [:last_name, :middle_name, :company].each do |attr|
        contact = Contact.new(@valid_attributes)
        contact.send("#{attr}=", "test")
        contact.should be_valid
      end
      
    end
    
  end

  context "virtual attributes" do
    
    it "name returns first_name if is_company is true" do
      contact = Contact.new(@valid_attributes.merge(:first_name => 'zackboom', :last_name => "Doe", :middle_name => "unknown", :is_company => true))
      contact.name.should == "zackboom"
    end
    
    it "name returns last_name, first_name and middle_name joined with a space if is_company is false" do
      contact = Contact.new(@valid_attributes.merge(:first_name => 'John', :last_name => "Doe", :middle_name => nil, :is_company => false))
      contact.name.should == "Doe John"
      contact.middle_name = "unknown"
      contact.name.should == "Doe John unknown"
    end
    
  end
  
  context "protected attributes" do
    
    it "should not mass assign created_by and updated_by ids" do
      contact = Contact.new(@valid_attributes.merge(:created_by_id => 1, :updated_by_id => 1))
      contact.created_by_id.should == nil
      contact.updated_by_id.should == nil
    end
    
  end

end