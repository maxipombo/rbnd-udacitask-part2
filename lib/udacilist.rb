class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    case type
    when "todo"
      @items.push TodoItem.new(description, options)
    when "event"
      @items.push EventItem.new(description, options)
    when "link"
      @items.push LinkItem.new(description, options)
    else # The ItemType could be only 'todo', 'event' or 'link'
      raise UdaciListErrors::InvalidItemType, "Try 'todo', 'event' or 'link'"
    end
  end

  def delete(index)
    if index < @items.length
      @items.delete_at(index - 1)
    else # The number index could be only < items length
      raise UdaciListErrors::IndexExceedsListSize, "#{index} isn't valid"
    end
  end

  def all
    puts "-" * @title.to_s.length
    puts @title
    puts "-" * @title.to_s.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  # Filter by item type
  def filter(type)
      type = type.downcase
      case type
        when "todo"
          filtered_items = @items.select{|item| item.type == type}
          return_filter(filtered_items)
        when "event"
          filtered_items = @items.select{|item| item.type == type}
          return_filter(filtered_items)
        when "link"
          filtered_items = @items.select{|item| item.type == type}
          return_filter(filtered_items)
        else
          raise UdaciListErrors::InvalidItemType, "Try 'todo', 'event' or 'link'"
      end
  end

  # Print the filtered items
  def return_filter(filtered_items)
    puts "-" * @title.to_s.length
    puts (@title)
    puts "-" * @title.to_s.length
    filtered_items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details(position)}"
    end
  end

end
