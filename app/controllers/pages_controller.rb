class PagesController < ApplicationController
  before_filter :login_required
  
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
    @page.user = @current_user
    if @page.save
      flash[:notice] = "Successfully created page."
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
    redirect_to pages_url
  end
end
