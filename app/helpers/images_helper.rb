module ImagesHelper
  def search_image
    image_tag 'search.png', :size => '16x16'
  end
  
  def true_image
    image_tag "true.png", :size => '16x16'
  end
  
  def false_image
    image_tag "false.png", :size => '16x16'
  end
  
  def boolean_image(bool, show_false = true)
    case bool
      when true
        true_image
      else
        false_image if show_false
    end
  end
  
  def priority_image(priority = 2)
    image_tag "priority_#{priority}.gif"
  end
  
  def edit_image
    image_tag "edit_button.png", :class => 'button'
  end
  
  def delete_image
    image_tag "delete.png"
  end
  
  def index_image
    image_tag "index.png", :size => '16x16'
  end
  
  def watch_image
    image_tag "watch.png", :class => 'button'
  end
  
  def unwatch_image
    image_tag "unwatch.png", :class => 'button'
  end
  
  def tick_image
    image_tag "tick.png"
  end
  
  def cross_image
    image_tag "cross.png"
  end
  
  def public_image
    image_tag "public.png", :title => 'Published'
  end
  
  def private_image
    image_tag "private.png"
  end

  def message_image
    image_tag "message.png"
  end      
  
  def feed_image
    image_tag 'feed.png'
  end

  def in_time_image(in_time)
    if in_time
      image_tag "true.png", :size => '16x16', :title => 'This ticket is in time'
    else
      image_tag "false.png", :size => '16x16', :title => 'This ticket is NOT in time'
    end
  end
end