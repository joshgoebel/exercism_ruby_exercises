class Clock
  include Comparable
  MINUTES_IN_DAY = 60 * 24
  private_constant :MINUTES_IN_DAY

  attr_reader :hours, :minutes

  def initialize(hour:0, minute:0)
    @value = (hour * 60 + minute) % MINUTES_IN_DAY
    @hours, @minutes = @value.divmod(60)
  end

  def to_s
    format("%<hours>02d:%<minutes>02d", { hours: hours, minutes: minutes })
  end

  def +(other)
    self.class.new(minute: value + other.value)
  end

  def -(other)
    self.class.new(minute: value - other.value)
  end

  def ==(x)
    value == x.value
  end

  def <=>(other)
    value <=> other.value
  end

  protected

  attr_reader :value

end
