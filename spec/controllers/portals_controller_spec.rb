require File.dirname(__FILE__) + '/../spec_helper'
 
describe PortalsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:portal)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Portal.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Portal.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(portal_url(assigns[:portal]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory(:portal)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    portal = Factory(:portal)
    Portal.any_instance.stubs(:valid?).returns(false)
    put :update, :id => portal
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Portal.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory(:portal)
    response.should redirect_to(portal_url(assigns[:portal]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    portal = Factory(:portal)
    delete :destroy, :id => portal
    response.should redirect_to(portals_url)
    Portal.exists?(portal.id).should be_false
  end
end
