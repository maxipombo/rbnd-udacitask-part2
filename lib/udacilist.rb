class UdaciList
  attr_reader :items
  attr_accessor :title

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end

  def add(type, description, options={})
    type = type.downcase
    allowed_types = { todo: TodoItem, link: LinkItem, event: EventItem }
    if allowed_types.keys.include? type.to_sym
      @items.push allowed_types[type.to_sym].new description, options
    else
      raise UdaciListErrors::InvalidItemType, "#{type} type doesn't exist".red
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
    table = filter_for_table(@items)
    puts table
  end

  # For Gem Terminal Table
  def filter_for_table(list)
    rows = []
    list.each_with_index do |item, position|
      rows << [position + 1, item.details]
    end
    Terminal::Table.new :title => @title,
    :headings => ["Num", "Details"],
    :rows => rows
  end

  # Filter by item type
  def filter(type)
    type = type.downcase
    if type == "todo"
      filtered_items = items.select {|item| item.is_a?(TodoItem)}
    elsif type == "event"
      filtered_items = items.select {|item| item.is_a?(EventItem)}
    elsif type == "link"
      filtered_items = items.select {|item| item.is_a?(LinkItem)}
    else
      raise UdaciListErrors::InvalidItemType, "Try 'todo', 'event' or 'link'"
    end
    return_filter(filtered_items)
  end

  # Print the filtered items
  def return_filter(filtered_items)
    table = filter_for_table(@items)
    puts table
  end

  # Add change priority module
  def change_priority(index, priority)
    raise UdaciListErrors::IncorrectItemType, "This item is not todo" unless @items[index-1].class.name.downcase.include? "todo"
    @items[index-1].priority = priority
  end

end
