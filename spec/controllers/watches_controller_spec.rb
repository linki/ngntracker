require File.dirname(__FILE__) + '/../spec_helper'
 
describe WatchesController do
  integrate_views
  
  before { @user = login_as_user }
    
  it "create action should render new template when model is invalid" do
    Watch.any_instance.stubs(:valid?).returns(false)
    post :create, :ticket_id => Factory(:ticket)
    response.should redirect_to(ticket_url(assigns[:ticket]))
  end
  
  it "create action should redirect when model is valid" do
    Watch.any_instance.stubs(:valid?).returns(true)
    post :create, :ticket_id => Factory(:ticket)
    response.should redirect_to(ticket_url(assigns[:ticket]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    ticket = Factory(:ticket)    
    watch = Factory(:watch, :user => @user, :ticket => ticket)
    delete :destroy, :ticket_id => ticket
    response.should redirect_to(ticket_url(ticket))
    Watch.exists?(watch.id).should be_false
  end
end
