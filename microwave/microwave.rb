class Microwave
  attr_reader :minutes, :seconds

  def initialize(time)
    @time = time
  end

  def normalize
    @minutes, @seconds = @time.divmod(100)
    return if seconds < 60

    m, s = seconds.divmod(60)
    @minutes += m
    @seconds = s
  end

  def timer
    normalize
    format("%02d:%02d", minutes, seconds)
  end
end