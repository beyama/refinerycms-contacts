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

  acts_as_indexed :fields => [:first_name, :middle_name, :last_name, :company, :address, :phone, :email, :website, :job_title, :background]

  validates :first_name, :presence => true
  validates_uniqueness_of :first_name, :scope => [:last_name, :middle_name, :company]
  
  belongs_to :avatar, :class_name => 'Image'
  
  belongs_to :created_by, :class_name => 'User'
  belongs_to :updated_by, :class_name => 'User'
  
  before_validation :nullify_blank_values
  
  def name
    (is_company ? [first_name] : [last_name, first_name, middle_name]).reject(&:blank?).join(" ")
  end
  
  protected
  def nullify_blank_values
    [:middle_name, :last_name, :company].each do |col|
      write_attribute(col, nil) if read_attribute(col).blank?
    end
  end
  
end
