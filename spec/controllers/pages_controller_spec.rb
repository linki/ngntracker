require File.dirname(__FILE__) + '/../spec_helper'
 
describe PagesController do
  fixtures :all
  integrate_views
  
  before { login_as_user }
  
  it "index action should render index template" do
    get :index, :ticket_id => Factory(:ticket)
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:page)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new, :ticket_id => Factory(:ticket)
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Page.any_instance.stubs(:valid?).returns(false)
    post :create, :ticket_id => Factory(:ticket)
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Page.any_instance.stubs(:valid?).returns(true)
    post :create, :ticket_id => Factory(:ticket)
    response.should redirect_to(page_url(assigns[:page]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory(:page)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    page = Factory(:page)
    Page.any_instance.stubs(:valid?).returns(false)
    put :update, :id => page
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Page.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory(:page)
    response.should redirect_to(page_url(assigns[:page]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    page = Factory(:page)
    delete :destroy, :id => page
    response.should redirect_to(ticket_pages_url(page.ticket))
    Page.exists?(page.id).should be_false
  end
end
