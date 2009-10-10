module TimeAndDateHelper
  def time(datetime)
    datetime.strftime('%b %d at %H:%M') unless datetime.nil?
  end
  
  def year(datetime)
    datetime.strftime('%Y') unless datetime.nil?
  end

  def date(datetime, options = {})
    unless datetime.nil?
      options.reverse_merge!(:year => true)
      format = '%b %d'
      format += ', %Y' if options[:year]
      datetime.strftime(format)
    end
  end
  
  def timespan(starts_at, ends_at, options = {})
    if starts_at.beginning_of_day == ends_at.beginning_of_day
      date(starts_at, options)
    else
      date(starts_at, :year => starts_at.year != ends_at.year) + " - " + date(ends_at, options)
    end
  end  
end