class Microwave
  attr_reader :minutes, :seconds

  def initialize(time)
    @minutes, @seconds = normalize(time)
  end

  def normalize(time)
    time.divmod(
      three_digit_entry?(time) ? 100 : 60
    )
  end

  def three_digit_entry?(time)
    time >= 100
  end

  def timer
    format("%02d:%02d", minutes, seconds)
  end
end