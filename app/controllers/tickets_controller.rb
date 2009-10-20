class TicketsController < InheritedResources::Base
  before_filter :login_required, :except => [:new, :create]
  
  respond_to :html, :json
  
  def index
    @tickets = Ticket.deleted(params[:deleted]).archived(params[:archived]).published.recent
    index!
  end
  
  def show
    @ticket  = Ticket.find(params[:id])
    @comment = Comment.new
    @watch = @current_user.watch_of(@ticket)
    @visit = @current_user.visit_of(@ticket)
    @current_user.visit!(@ticket)
    show!
  end
    
  def create
    @ticket = Ticket.new(params[:ticket])
    if logged_in?
      @ticket.user = current_user
    else
      # make that better
      @ticket.user = User.create!(:username => params[:ticket][:user][:email], :email => params[:ticket][:user][:email], :password => 'testtest', :password_confirmation => 'testtest') unless params[:ticket][:user][:email].blank?
    end
    if @ticket.save
      set_flash_message!(:notice, '{{resource_name}} was successfully created.')
    end
    create!
  end
    
  def archive
    @ticket = Ticket.find(params[:id])
    @ticket.archive
    set_flash_message!(:notice, '{{resource_name}} was successfully archived.')
    redirect_to tickets_url
  end
  
  def destroy
    @ticket = Ticket.find(params[:id])
    @ticket.destroy_or_trash
    set_flash_message!(:notice, '{{resource_name}} was successfully destroyed.')
    redirect_to tickets_url
  end
end