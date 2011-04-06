class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table ::Note.table_name do |t|
      t.column :subject, :string
      t.column :content, :text
      t.references :source, :polymorphic => true
      t.references :created_by
      t.references :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table ::Note.table_name
  end
end
