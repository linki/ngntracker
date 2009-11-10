class UsersController < ApplicationController
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
    render :action => 'signup' unless logged_in?
  end
  
  def create
    @user = User.new(params[:user])
    unless params[:user][:perishable_token].blank?
      user = User.find_by_perishable_token(params[:user][:perishable_token])
      if user && user.update_attributes(params[:user])
        flash[:notice] = "Successfully registered your account."
        redirect_to user
      else
        render :action => (logged_in? ? 'new' : 'signup')
      end
    else
      if (@user.valid? || @user.errors.on(:email).nil? || @user.errors.on(:email).empty?) && @user.save_without_session_maintenance(false)
        if logged_in?
          flash[:notice] = "Successfully created user."
          Mailer.deliver_signup(@user)
        else
          flash[:notice] = "Check your emails for your registration code."
          Mailer.deliver_invitation(@user)
        end
        redirect_to @user
      else
        render :action => (logged_in? ? 'new' : 'signup')
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated user."
      redirect_to @user
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Successfully destroyed user."
    redirect_to users_url
  end
end
