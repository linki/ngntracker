class TicketsController < ApplicationController
  before_filter :login_required
  
  def index
    @tickets = Ticket.published.recent
  end
  
  def show
    @ticket = Ticket.find(params[:id])
    @visit = @current_user.visit_of(@ticket)
    @current_user.visit!(@ticket)
  end
  
  def new
    @ticket = Ticket.new
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.user = current_user    
    if @ticket.save
      flash[:notice] = "Successfully created ticket."
      redirect_to @ticket
    else
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
  
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy
    flash[:notice] = "Successfully destroyed ticket."
    redirect_to tickets_url
  end
end
