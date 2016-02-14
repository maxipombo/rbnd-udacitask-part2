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
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

end
