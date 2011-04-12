module Admin::ContactsHelper
  
  include ActsAsTaggableOn::TagsHelper if Contact.taggable?
  
  def organisation_context_label(form, sym)
    scope   = 'activerecord.attributes.contact'
    natural = t(sym, :scope => scope)
    organisation = t("#{sym}_on_organisation", :scope => scope)
    form.label(sym, @contact.is_organisation ? organisation : natural, :organisation_title => organisation, :natural_title => natural, :class => "organisation_context")
  end
  
  def contact_headline(contact)
    t((contact.is_organisation ? '.organisation' : '.contact')) + " ##{contact.id}"
  end
  
  def tagarea_dom_id(contact)
    "#{dom_id contact}_tags"
  end
  
  def contact_role(c)
    if c.is_organisation
      c.job_title
    else
      if !c.job_title.blank? && !c.organisation.blank?
        t('contacts.role_at_organisation', :role => c.job_title, :organisation => c.organisation)
      elsif !c.job_title.blank?
        c.job_title
      elsif !c.organisation.blank?
        c.organisation
      end
    end
  end
  
end