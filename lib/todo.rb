class TodoItem
  include Listable
  attr_reader :description, :due
  attr_accessor :priority

  # Define priorities allowed
  @@priorities = ["high", "medium", "low", nil]

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]

    # For InvalidPriorityValue error
    @@priorities.include?(options[:priority]) ? (@priority = options[:priority]) : (raise UdaciListErrors::InvalidPriorityValue, "'#{options[:priority]}' is an invalid prioritization.")
  end

  def details
    format_description + "due: " +
    format_date(2) +
    format_priority
  end

end
