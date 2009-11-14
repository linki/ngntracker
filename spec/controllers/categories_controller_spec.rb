require File.dirname(__FILE__) + '/../spec_helper'
 
describe CategoriesController do
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory(:category)
    response.should render_template(:show)
  end
  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Category.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Category.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(category_url(assigns[:category]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory(:category)
    response.should render_template(:edit)
  end
  
  it "update action should render edit template when model is invalid" do
    category = Factory(:category)
    Category.any_instance.stubs(:valid?).returns(false)
    put :update, :id => category
    response.should render_template(:edit)
  end
  
  it "update action should redirect when model is valid" do
    Category.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Factory(:category)
    response.should redirect_to(category_url(assigns[:category]))
  end
  
  it "destroy action should destroy model and redirect to index action" do
    category = Factory(:category)
    delete :destroy, :id => category
    response.should redirect_to(categories_url)
    Category.exists?(category.id).should be_false
  end
end
