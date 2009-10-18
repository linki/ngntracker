class WatchesController < ApplicationController
  before_filter :login_required
  before_filter :find_ticket, :only => :create
  
  def create
    if @current_user.watch!(@ticket)
      flash[:notice] = "Successfully created watch."
    else
      flash[:error] = "Could not create watch."
    end
    redirect_to @ticket    
  end
  
  def destroy
    @watch = @current_user.watches.find(params[:id])
    @watch.destroy
    flash[:notice] = "Successfully destroyed watch."
    redirect_to @watch.ticket
  end
  
  private
  
  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end  
end
