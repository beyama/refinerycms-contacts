class AddFieldsAndStiSupportToContacts < ActiveRecord::Migration
  def self.up
    change_table ::Contact.table_name do |t|
      t.string  :title, :limit => 20
      t.string  :zip, :limit => 20
      t.string  :city, :limit => 100
      t.string  :country, :limit => 100
      t.string  :mobile
      t.string  :type
      t.boolean :system, :default => false
      t.boolean :hidden, :default => false
      
      t.rename :company, :organisation
      t.rename :is_company, :is_organisation
    end
    
    remove_index ::Contact.table_name, :name => "index_unique_#{::Contact.table_name}"
    
    add_index ::Contact.table_name, :type
    add_index ::Contact.table_name, [:first_name, :last_name, :organisation]
  end

  def self.down
  end
end
