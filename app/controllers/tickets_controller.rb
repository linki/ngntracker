class TicketsController < ApplicationController
  before_filter :load_and_authorize_resource
  
  def index
    @search = Ticket.active.visible_for(@current_user).recent.search(params[:search])
    @tickets = @search.paginate(:page => params[:page])
  end
  
  def show
    @comment = Comment.new
    @visit = @current_user.visit_of(@ticket)
    @current_user.visit!(@ticket)
  end
  
  def new
  end
  
  def create
    if logged_in?
      @ticket.user = @current_user
    else
      # make that better
      @ticket.user = User.create!(:name => params[:ticket][:user][:email].split('@').first.titleize.gsub('.', ' '), :login => params[:ticket][:user][:email].split('@').first, :email => params[:ticket][:user][:email], :password => 'testtest', :password_confirmation => 'testtest') unless params[:ticket][:user][:email].blank?
    end
    if @ticket.save
      flash[:notice] = "Successfully created ticket."
      redirect_to @ticket
    else
      flash.now[:error] = "Error while creating ticket."
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = "Successfully updated ticket."
      redirect_to @ticket
    else
      render :action => 'edit'
    end
  end
    
  def destroy
    @ticket.destroy_or_trash!
    flash[:notice] = "Successfully deleted the ticket."
    redirect_to tickets_url
  end

  def archived
    @search = Ticket.not_deleted.archived.visible_for(@current_user).recent.search(params[:search])
    @tickets = @search.all
    render :action => 'index'
  end
  
  def deleted
    @search = Ticket.deleted.visible_for(@current_user).recent.search(params[:search])
    @tickets = @search.all
    render :action => 'index'
  end
  
  def watched
    @search = @current_user.watched_tickets.visible_for(@current_user).recent.search(params[:search])
    @tickets = @search.all
    render :action => 'index'
  end

  def close
    @ticket.close!
    flash[:notice] = "Successfully closed the ticket."
    redirect_to @ticket
  end
  
  def archive
    @ticket.archive!
    flash[:notice] = "Successfully archived the ticket."
    redirect_to tickets_url
  end

  def unarchive
    @ticket.unarchive!
    flash[:notice] = "Successfully unarchived the ticket."
    redirect_to @ticket
  end
  
  def recycle
    @ticket.recycle!
    flash[:notice] = "Successfully recycled the ticket."
    redirect_to @ticket
  end
end
