class TicketsController < ApplicationController
  before_filter :login_required, :except => [:new, :create]
  
  def index
    @tickets = Ticket.search(params)
  end
  
  def show
    @ticket  = Ticket.find(params[:id])
    @comment = Comment.new
    @watch = @current_user.watch_of(@ticket)
    @visit = @current_user.visit_of(@ticket)
    @current_user.visit!(@ticket)
  end
  
  def new
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    if logged_in?
      @ticket.user = current_user
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
    @ticket = Ticket.find(params[:id])
  end
  
  def update
    @ticket = Ticket.find(params[:id])
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = "Successfully updated ticket."
      redirect_to @ticket
    else
      render :action => 'edit'
    end
  end
    
  def archive
    @ticket = Ticket.find(params[:id])
    @ticket.archive!
    flash[:notice] = "Successfully archived ticket."
    redirect_to tickets_url
  end
  
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy_or_trash!
    flash[:notice] = "Successfully destroyed ticket."
    redirect_to tickets_url
  end
end
