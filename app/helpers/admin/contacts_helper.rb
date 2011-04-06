module Admin::ContactsHelper
  
  include ActsAsTaggableOn::TagsHelper if Contact.taggable?
  
  def company_context_label(form, sym)
    scope   = 'activerecord.attributes.contact'
    natural = t(sym, :scope => scope)
    company = t("#{sym}_company", :scope => scope)
    form.label(sym, @contact.is_company ? company : natural, :company_title => company, :natural_title => natural, :class => "company_context")
  end
  
  def contact_headline(contact)
    t((contact.is_company ? '.company' : '.contact')) + " ##{contact.id}"
  end
  
  def tagarea_dom_id(contact)
    "#{dom_id contact}_tags"
  end
  
  def contact_role(c)
    if c.is_company
      c.job_title
    else
      if !c.job_title.blank? && !c.company.blank?
        t('contacts.role_at_company', :role => c.job_title, :company => c.company)
      elsif !c.job_title.blank?
        c.job_title
      elsif !c.company.blank?
        c.company
      end
    end
  end
  
end