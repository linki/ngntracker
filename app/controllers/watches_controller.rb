class WatchesController < ApplicationController
  before_filter :login_required
  before_filter :find_ticket
  
  def create
    if @current_user.watch!(@ticket)
      flash[:notice] = "You are now watching the ticket."
    else
      flash[:error] = "Could not create watch."
    end
    redirect_to @ticket    
  end
  
  def destroy
    @watch = @current_user.watches.find_by_ticket_id!(@ticket)
    @watch.destroy
    flash[:notice] = "You are no longer watching the ticket."
    redirect_to @watch.ticket
  end
  
  private
  
  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end  
end
