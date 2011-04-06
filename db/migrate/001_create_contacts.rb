class CreateContacts < ActiveRecord::Migration

  def self.up
    create_table ::Contact.table_name do |t|
      t.string  :first_name
      t.string  :middle_name
      t.string  :last_name
      t.string  :company
      t.string  :address
      t.integer :avatar_id
      t.string  :phone
      t.string  :email
      t.string  :website
      t.string  :job_title
      t.date    :birthday
      t.text    :background
      t.boolean :is_company

      t.timestamps
    end

    add_index ::Contact.table_name, :id
    add_index ::Contact.table_name, [:first_name], :name => "index_#{::Contact.table_name}_on_first_name"
    add_index ::Contact.table_name, [:first_name, :last_name, :company], :name => "index_unique_#{::Contact.table_name}", :unique => true
    
    load(Rails.root.join('db', 'seeds', 'contacts.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "contacts"})

    drop_table ::Contact.table_name
  end

end
