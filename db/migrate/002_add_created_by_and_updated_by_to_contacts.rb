class AddCreatedByAndUpdatedByToContacts < ActiveRecord::Migration
  def self.up
    add_column ::Contact.table_name, :created_by_id, :integer
    add_column ::Contact.table_name, :updated_by_id, :integer
  end

  def self.down
    remove_column ::Contact.table_name, :updated_by_id
    remove_column ::Contact.table_name, :created_by_id
  end
end
