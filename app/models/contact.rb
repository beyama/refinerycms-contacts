class Contact < ActiveRecord::Base
  
  FRONTEND_TAGS = ['frontend']
  
  has_many :notes, :as => :source, :dependent => :delete_all, :order => "created_at DESC"
  
  if defined? ActsAsTaggableOn
    acts_as_taggable
  else
    def self.taggable?
      false
    end
  end
  
  attr_protected :created_by_id, :updated_by_id

  acts_as_indexed :fields => [:first_name, :middle_name, :last_name, :organisation, :address, :phone, :mobile, :email, :website, :job_title]

  validates :last_name, :presence => true, :unless => :organisation?
  validates :organisation, :presence => true, :if => :organisation?
  
  belongs_to :avatar, :class_name => 'Image'
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  
  default_scope where(:hidden => false)
  
  def name
    is_organisation ? organisation : contact_person
  end
  
  def contact_person
    [last_name, first_name, middle_name].reject(&:blank?).join(" ")
  end
  
  def organisation?
    !!is_organisation
  end
  
  def hidden?
    hidden
  end
  
  def system?
    system
  end
end