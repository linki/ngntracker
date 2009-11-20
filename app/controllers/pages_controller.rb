class PagesController < ApplicationController
  before_filter :load_and_authorize_resource
  
  # before_filter :find_ticket, :only => [:index, :new, :create]  
  
  def index
    @pages = Page.all
  end
  
  def show
    @page = Page.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    @page = Page.new(:name => params[:id].titleize, :permalink => params[:id])
    render :action => 'new'
  end
  
  def new
    @page = Page.new
  end
  
  def create
    @page = Page.new(params[:page])
    @page.ticket = @ticket
    @page.user   = @current_user
    if @page.save
      flash[:notice] = "Successfully created the page."
      redirect_to @page
    else
      render :action => 'new'
    end
  end
  
  def edit
    @page = Page.find(params[:id])
  end
  
  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(params[:page])
      flash[:notice] = "Successfully updated page."
      redirect_to @page
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @page = Page.find(params[:id])
    @page.destroy
    flash[:notice] = "Successfully destroyed page."
    redirect_to ticket_pages_url(@page.ticket)
  end
  
  private
  
  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end  
end
