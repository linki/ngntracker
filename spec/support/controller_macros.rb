module ControllerMacros
  def login_as_user
    login(User.find_by_login('martin') || Factory(:user, :login => 'martin', :password => 'secret')) 
  end

  def login(user)
    activate_authlogic
    UserSession.stubs(:find).returns(UserSession.create!(user))
    user
  end  
end