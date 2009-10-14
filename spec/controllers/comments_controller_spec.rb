require File.dirname(__FILE__) + '/../spec_helper'
 
describe CommentsController do
  fixtures :all
  integrate_views
  
  before { login_as_user }
    
  it "index action should render index template" do
    get :index, :ticket_id => Factory(:ticket)
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:comment)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new, :ticket_id => Factory(:ticket)
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create, :ticket_id => Factory(:ticket)
    response.should render_template(:new)
  end
  
  it "create action should redirect to parent when model is valid" do
    Comment.any_instance.stubs(:valid?).returns(true)
    post :create, :ticket_id => Factory(:ticket)
    response.should redirect_to(ticket_url(assigns[:ticket]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory(:comment)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    comment = Factory(:comment)
    Comment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => comment
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Comment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory(:comment)
    response.should redirect_to(comment_url(assigns[:comment]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    comment = Factory(:comment)
    delete :destroy, :id => comment
    response.should redirect_to(ticket_comments_url(comment.ticket))
    Comment.exists?(comment.id).should be_false
  end
end
