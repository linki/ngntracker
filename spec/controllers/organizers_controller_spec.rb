require File.dirname(__FILE__) + '/../spec_helper'
 
describe OrganizersController do
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:organizer)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Organizer.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Organizer.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(organizer_url(assigns[:organizer]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory(:organizer)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    organizer = Factory(:organizer)
    Organizer.any_instance.stubs(:valid?).returns(false)
    put :update, :id => organizer
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Organizer.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory(:organizer)
    response.should redirect_to(organizer_url(assigns[:organizer]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    organizer = Factory(:organizer)
    delete :destroy, :id => organizer
    response.should redirect_to(organizers_url)
    Organizer.exists?(organizer.id).should be_false
  end
end
