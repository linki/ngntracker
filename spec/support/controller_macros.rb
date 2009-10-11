module ControllerMacros
  def login_as_user
    login(User.find_by_username('martin') || Factory(:user, :username => 'martin', :password => 'secret')) 
  end

  def login(user)
    activate_authlogic
    UserSession.stubs(:find).returns(UserSession.create!(user))
  end  
end