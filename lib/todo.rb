class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    # For InvalidPriorityValue error
    return unless options[:priority]
    unless %w(high medium low).include?(options[:priority])
      raise UdaciListErrors::InvalidPriorityValue, "#{options[:priority]} isn't valid."
    end
    @priority = options[:priority]
  end

  def details
    format_description + "due: " +
    format_date(2) +
    format_priority
  end

end
