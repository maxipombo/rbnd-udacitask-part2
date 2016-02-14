module Listable

  def format_description
    "#{description}".ljust(25)
  end

  def format_priority
    value = " ⇧" if priority == "high"
    value = " ⇨" if priority == "medium"
    value = " ⇩" if priority == "low"
    value = "" if !priority
    return value
  end

  def format_date(number)
    if number == 1
      dates = @start_date.strftime("%D") if @start_date
      dates << " -- " + @end_date.strftime("%D") if @end_date
      dates = "N/A" if !dates
      return dates
    else
      @due ? @due.strftime("%D") : "No due date"
    end
  end

  def format_name
    @site_name ? @site_name : ""
  end

end
