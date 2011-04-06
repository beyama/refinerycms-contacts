class Admin::NotesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, :with => :error_404

  before_filter :find_note_source
  before_filter :find_note, :only => :update
  
  def create
    @note = Note.new(params[:note])
    @note.created_by = current_user
    @note.source = @source
    if @note.save
      flash.notice = t('admin.notes.flash.created')
      redirect_to_source
    else
      redirect_to :back
    end
  end
  
  def update
    @note.attributes = params[:note]
    @note.updated_by = current_user
    if @note.save
      flash.notice = t('admin.notes.flash.updated')
      redirect_to_source
    else
      redirect_to :back
    end
  end  
  
  protected
  
  def redirect_to_source
    redirect_to polymorphic_path([:admin, @source])
  end
  
  def find_note
    @note = @source.notes.find(params[:id])
  end
  
  def find_note_source
    key = params.keys.find {|k,v| k =~ /^(\S+)_id$/}
    @source_klass = Object.const_get($1.camelcase)
    @source = @source_klass.find(params[key])
  rescue => e
    error_404(e)
  end
  
end
