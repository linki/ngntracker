class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    else
      can :read, Ticket do |ticket|
        ticket.nil? || ticket.published? || ticket.user == user
        # deleted, archived?
      end
      
      can :read, Page do |page|
        page.nil? || page.published?
        # index, created by me?
      end
    end
  end
end