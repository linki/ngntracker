module TicketsHelper
  def assigned_to(user)
    user == @current_user ? "<strong>YOU</strong>" : h(user.name) if user
  end
end