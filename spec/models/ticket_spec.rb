require File.dirname(__FILE__) + '/../spec_helper'

describe Ticket do
  it "should be valid" do
    Factory.build(:ticket).should be_valid
  end
  
  it "should require a name" do
    Factory.build(:ticket, :name => '').should_not be_valid
  end

  it "should require a description" do
    Factory.build(:ticket, :description => '').should_not be_valid
  end

  it "should require a category" do
    Factory.build(:ticket, :category => nil).should_not be_valid
  end
  
  it "should assign a user" do
    user = Factory(:user)
    Factory.build(:ticket, :user => user).user.should == user
  end  

  it "should assign a category" do
    category = Factory(:category)
    Factory.build(:ticket, :category => category).category.should == category
  end  

  it "should assign an organizer" do
    organizer = Factory(:organizer)
    Factory.build(:ticket, :organizer => organizer).organizer.should == organizer
  end  
  
  it "should assign a portal" do
    portal = Factory(:portal)
    Factory.build(:ticket, :portal => portal).portal.should == portal
  end
  
  it "should assign comments" do
    comments = [Factory(:comment)]
    Factory.build(:ticket, :comments => comments).comments.should == comments
  end

  it "should assign pages" do
    pages = [Factory(:page)]
    Factory.build(:ticket, :pages => pages).pages.should == pages
  end  
  
  it "should assign watches" do
    watches = [Factory(:watch)]
    Factory.build(:ticket, :watches => watches).watches.should == watches
  end

  it "should assign watching users" do
    watching_users = [Factory(:user)]
    Factory.build(:ticket, :watching_users => watching_users).watching_users.should == watching_users
  end
  
  it "should assign visits" do
    visits = [Factory(:visit)]
    Factory.build(:ticket, :visits => visits).visits.should == visits
  end
  
  describe "close" do
    it "should be open" do
      Factory(:ticket).should be_open
    end
    
    it "should close" do
      ticket = Factory(:ticket)
      ticket.close!
      ticket.reload
      ticket.should be_closed
    end
  end

  describe "archivable" do
    it "should not be archived" do
      Factory(:ticket).should_not be_archived
    end
    
    it "should archive" do
      ticket = Factory(:ticket)
      ticket.archive!
      ticket.reload
      ticket.should be_archived
    end
    
    it "should be archived" do
      Factory(:ticket, :archived_at => Time.now - 1.day).should be_archived
    end
    
    it "should unarchive" do
      ticket = Factory(:ticket, :archived_at => Time.now - 1.day)
      ticket.unarchive!
      ticket.reload
      ticket.should_not be_archived
    end
    
    it "should find archived" do
      ticket_1 = Factory(:ticket)
      ticket_2 = Factory(:ticket, :archived_at => Time.now - 1.day)
      Ticket.archived.should == [ticket_2]
    end
    
    it "should find not archived" do
      ticket_1 = Factory(:ticket)
      ticket_2 = Factory(:ticket, :archived_at => Time.now - 1.day)
      Ticket.not_archived.should == [ticket_1]
    end
    
    it "should set archived" do
      ticket = Factory(:ticket)
      ticket.archived = true
      ticket.should be_archived
    end
    
    it "should get archived" do
      Factory(:ticket, :archived_at => Time.now - 1.day).archived.should == true
    end
  end
  
  describe "publishable" do
    it "should not be published" do
      Factory(:ticket).should_not be_published
    end
    
    it "should publish" do
      ticket = Factory(:ticket)
      ticket.publish!
      ticket.reload
      ticket.should be_published
    end
    
    it "should be published" do
      Factory(:ticket, :published_at => Time.now - 1.day).should be_published
    end
    
    it "should unpublish" do
      ticket = Factory(:ticket, :published_at => Time.now - 1.day)
      ticket.unpublish!
      ticket.reload
      ticket.should_not be_published
    end
    
    it "should find published" do
      ticket_1 = Factory(:ticket)
      ticket_2 = Factory(:ticket, :published_at => Time.now - 1.day)
      Ticket.published.should == [ticket_2]
    end
    
    it "should find unpublished" do
      ticket_1 = Factory(:ticket)
      ticket_2 = Factory(:ticket, :published_at => Time.now - 1.day)
      Ticket.unpublished.should == [ticket_1]
    end
    
    it "should set published" do
      ticket = Factory(:ticket)
      ticket.published = true
      ticket.should be_published
    end
    
    it "should get published" do
      Factory(:ticket, :published_at => Time.now - 1.day).published.should == true
    end
  end
  
  describe "recyclable" do
    it "should not be deleted" do
      Factory(:ticket).should_not be_deleted
    end
    
    it "should trash" do
      ticket = Factory(:ticket)
      ticket.trash!
      ticket.reload
      ticket.should be_deleted
    end
    
    it "should destroy after second trash or remove" do
      ticket = Factory(:ticket)
      ticket.destroy_or_trash!
      ticket.reload
      ticket.should be_deleted
      ticket.destroy_or_trash!
      Ticket.exists?(ticket.id).should be_false
    end    
    
    it "should be deleted" do
      Factory(:ticket, :deleted_at => Time.now - 1.day).should be_deleted
    end
    
    it "should recycle" do
      ticket = Factory(:ticket, :deleted_at => Time.now - 1.day)
      ticket.recycle!
      ticket.reload
      ticket.should_not be_deleted
    end
    
    it "should find deleted" do
      ticket_1 = Factory(:ticket)
      ticket_2 = Factory(:ticket, :deleted_at => Time.now - 1.day)
      Ticket.deleted.should == [ticket_2]
    end
    
    it "should find not deleted" do
      ticket_1 = Factory(:ticket)
      ticket_2 = Factory(:ticket, :deleted_at => Time.now - 1.day)
      Ticket.not_deleted.should == [ticket_1]
    end
  end  
  
  describe "assigned?" do
    before { @user = Factory(:user) }
    
    context "witout parameter" do
      it "should be true when assigned to anybody" do        
        Factory.build(:ticket, :assignee => @user).should be_assigned
      end
      
      it "should be false when assigned to nobody" do
        Factory.build(:ticket, :assignee => nil).should_not be_assigned
      end
    end
    
    context "with parameter" do
      it "should be true when assigned to given user" do
        Factory.build(:ticket, :assignee => @user).should be_assigned(@user)
      end
      
      it "should be false when assigned to another user" do
        another_user = Factory(:user)
        Factory.build(:ticket, :assignee => another_user).should_not be_assigned(@user)
      end
      
      it "should be false when assigned to nobody" do
        Factory.build(:ticket, :assignee => nil).should_not be_assigned(@user)
      end
    end
  end
end
