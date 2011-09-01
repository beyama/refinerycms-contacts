class ContactsController < ApplicationController

  helper_method :paginate?

  rescue_from ActiveRecord::RecordNotFound, :with => :error_404

  before_filter :find_all_contacts, :only => :index
  before_filter :find_contact, :only => :show
  before_filter :find_page

  def index
    present(@page)
  end

  def show
    # you can use meta fields from your model instead (e.g. browser_title)
    # by swapping @page for @contact in the line below:
    present(@page)
  end

protected

  def filter_tags
    Contact::FRONTEND_TAGS
  end

  def page_url
    "/contacts"
  end

  def filtered_contacts
    Contact.taggable? ? Contact.tagged_with(filter_tags, :any => true) : Contact
  end

  def find_all_contacts
    @contacts = filtered_contacts.order("organisation ASC").order("last_name ASC").order("first_name ASC")
    @contacts = paginate if paginate?
  end
  
  def paginate?
    true
  end
  
  def paginate
    @contacts.paginate({
      :page => params[:page],
      :per_page => RefinerySetting.find_or_set(:contacts_per_page, 10)
    })
  end
  
  def find_contact
    @contact = filtered_contacts.find(params[:id])
  end

  def find_page
    @page = Page.find_by_link_url(page_url)
    error_404 if @page.nil?
  end

end
