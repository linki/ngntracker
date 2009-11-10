class CommentsController < ApplicationController
  before_filter :login_required
  before_filter :find_ticket, :only => [:index, :new, :create]
  
  def index
    @comments = @ticket.comments
  end
  
  def show
    @comment = Comment.find(params[:id])
  end
  
  def new
    @comment = Comment.new
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.ticket = @ticket
    @comment.user   = @current_user
    if @comment.save
      flash[:notice] = "Successfully created your comment."
      redirect_to @comment.ticket
    else
      render :action => 'new'
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end
  
  def update
    @comment = Comment.find(params[:id])
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to @comment
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to ticket_comments_url(@comment.ticket)
  end
  
  private
  
  def find_ticket
    @ticket = Ticket.find(params[:ticket_id])
  end
end
