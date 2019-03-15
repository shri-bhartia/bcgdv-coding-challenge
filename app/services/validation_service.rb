class ValidationService

  def self.num?(input)
    return true if input.is_a?(Numeric)
    input.to_i.to_s == input
  end

  def self.str?(input)
    input.is_a?(String)
  end

  def self.time?(input)
    return false unless str?(input)

    seperator = ":"
    return false if input.count(seperator) != 2

    sliced_input = input.split(seperator)
    return false if sliced_input.length != 3

    hrs, min, sec = sliced_input[0], sliced_input[1], sliced_input[2]

    in_range?(0, 23, hrs)   &&
      in_range?(0, 59, min) &&
      in_range?(0, 59, sec)
  end

  def self.in_range?(lower_bound, upper_bound, value)
    value.to_i >= lower_bound && value.to_i <= upper_bound
  end
end