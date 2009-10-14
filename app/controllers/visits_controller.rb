class VisitsController < ApplicationController
  def index
    @visits = Visit.all
  end
  
  def show
    @visit = Visit.find(params[:id])
  end
  
  def new
    @visit = Visit.new
  end
  
  def create
    @visit = Visit.new(params[:visit])
    if @visit.save
      flash[:notice] = "Successfully created visit."
      redirect_to @visit
    else
      render :action => 'new'
    end
  end
  
  def edit
    @visit = Visit.find(params[:id])
  end
  
  def update
    @visit = Visit.find(params[:id])
    if @visit.update_attributes(params[:visit])
      flash[:notice] = "Successfully updated visit."
      redirect_to @visit
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @visit = Visit.find(params[:id])
    @visit.destroy
    flash[:notice] = "Successfully destroyed visit."
    redirect_to visits_url
  end
end
