require File.dirname(__FILE__) + '/../spec_helper'
 
describe TweetsController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:tweet)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Tweet.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Tweet.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(tweet_url(assigns[:tweet]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory(:tweet)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    tweet = Factory(:tweet)
    Tweet.any_instance.stubs(:valid?).returns(false)
    put :update, :id => tweet
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Tweet.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory(:tweet)
    response.should redirect_to(tweet_url(assigns[:tweet]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    tweet = Factory(:tweet)
    delete :destroy, :id => tweet
    response.should redirect_to(tweets_url)
    Tweet.exists?(tweet.id).should be_false
  end
end
