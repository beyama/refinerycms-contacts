module Admin
  class ContactsController < Admin::BaseController

    crudify :contact,
            :title_attribute => 'name',
            :sortable => false,
            :order => 'first_name ASC'

    helper :contacts

    def index
      search_all_contacts if searching?
      search_all_contacts_by_tag unless params[:tag].blank?
      
      find_all_contacts if @contacts.nil?
      @contacts = @contacts.visible
      
      paginate_all_contacts 

      @tags = Contact.tag_counts_on(:tags) if Contact.taggable?
      
      render :partial => 'contacts' if request.xhr?
    end
    
    def show
      @note = Note.new
    end
  
    def create
      @contact = Contact.new(params[:contact])
      @contact.created_by = current_user
      if @contact.save
        flash.notice = t('refinery.crudify.created', :what => "'#{@contact.name}'")
        redirect_to :action => :index
      else
        render :action => 'new'
      end
    end
    
    def update
      @contact.attributes = params[:contact]
      @contact.updated_by = current_user
      if @contact.save
        respond_to do |format|
          format.js { render 'tags' }
          format.html do
            flash.notice = t('refinery.crudify.updated', :what => "'#{@contact.name}'")
            redirect_to :action => :index
          end
        end
      else
        render :action => :edit
      end
    end
    
    def destroy
      render :nothing => true, :status => :forbidden and return if @contact.system
      
      if @contact.destroy
        flash.notice = t('destroyed', :scope => 'refinery.crudify', :what => "'#{@contact.name}'")
      end

      redirect_to :action => :index
    end
    
    protected
    def search_all_contacts_by_tag
      find_all_contacts if @contacts.nil?
      
      @contacts = @contacts.tagged_with(params[:tag])
    end

  end
end
