class Mailer < ActionMailer::Base
  def invitation(user)
    subject    'Your Registration Code'
    recipients user.email
    from       'foo@bar.com'
    body       :user => user
  end
  
  def signup(user)
    subject    'Successfully Registered'
    recipients user.email
    from       'foo@bar.com'
    body       :user => user
  end  
end
