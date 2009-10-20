class TicketsController < InheritedResources::Base
  before_filter :login_required, :except => [:new, :create]
  
  respond_to :html

  has_scope :published, :default => true, :boolean => true, :only => :index
  has_scope :archived, :default => false, :only => :index
  has_scope :deleted, :default => false, :only => :index  
  
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
    create!
  end
  
  def archive
    @ticket = Ticket.find(params[:id])
    @ticket.archive
    flash[:notice] = "Successfully archived ticket."
    redirect_to tickets_url
  end
end
