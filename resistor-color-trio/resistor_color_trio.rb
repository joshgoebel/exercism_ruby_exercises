class ResistorColorTrio

  BAND_to_RESISTANCE = {
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }.transform_keys(&:to_s)
  private_constant :BAND_to_RESISTANCE

  def initialize(bands)
    @bands = bands
    validate_bands!
  end

  def to_s
    v = kiloohms? ? resistance_value / 1000 : resistance_value
    "#{v} #{units}"
  end

  def label
    "Resistor value: #{self}"
  end

  private

  attr_reader :bands

  def validate_bands!
    invalid = bands.reject { |b| BAND_to_RESISTANCE.key?(b) }
    return if invalid.none?

    raise ArgumentError, "invalid bands: #{invalid}"
  end

  def resistance_value
    tens, ones, units = bands
    (BAND_to_RESISTANCE[tens] * 10 + BAND_to_RESISTANCE[ones]) * band_to_multiplier(units)
  end

  def band_to_multiplier(units)
    10**BAND_to_RESISTANCE[units]
  end

  def kiloohms?
    resistance_value >= 1000
  end

  def units
    kiloohms? ? "kiloohms" : "ohms"
  end

end
