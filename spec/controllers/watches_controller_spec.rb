require File.dirname(__FILE__) + '/../spec_helper'
 
describe WatchesController do
  fixtures :all
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
    watch = Factory(:watch, :user => @user)
    delete :destroy, :id => watch
    response.should redirect_to(ticket_url(watch.ticket))
    Watch.exists?(watch.id).should be_false
  end
end
