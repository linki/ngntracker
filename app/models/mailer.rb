class Mailer < ActionMailer::Base
  def signup(user)
    subject    'Successfully Registered'
    recipients user.email
    from       'foo@bar.com'
    body       :user => user
  end  
end
