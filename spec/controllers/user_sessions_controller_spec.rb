require File.dirname(__FILE__) + '/../spec_helper'
 
describe UserSessionsController do
  integrate_views
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when authentication is invalid" do
    Factory(:user, :login => 'foo', :password => 'secret')
    post :create, :user_session => { :login => "foo", :password => "badpassword" }
    response.should render_template(:new)
    UserSession.find.should be_nil
  end
  
  it "create action should redirect when authentication is valid" do
    user = Factory(:user, :login => 'foo', :password => 'secret')    
    post :create, :user_session => { :login => "foo", :password => "secret" }
    response.should redirect_to(root_url)
    UserSession.find.user.should == user
  end
end
