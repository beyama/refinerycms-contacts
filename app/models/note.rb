class Note < ActiveRecord::Base
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updared_by, :class_name => 'User'
  belongs_to :source, :polymorphic => true
  
  validates_presence_of :source, :created_by, :content
end
