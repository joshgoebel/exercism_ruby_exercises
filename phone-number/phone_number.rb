class PhoneNumber
  SPACE_or_PUNC = /[\(\). -]*/
  PHONE_RE = /
    ^
    \+?1?       # international prefix
    #{SPACE_or_PUNC}
    (\d{3})   # area code
    #{SPACE_or_PUNC}
    (\d{3})   # exchange code
    #{SPACE_or_PUNC}
    (\d{4})   # last 4 digits
    \s*
    $
  /x
  private_constant :PHONE_RE

  def self.clean(number)
    PhoneNumber.new(number).clean
  end

  def clean
    m, area_code, exchange, local = PHONE_RE.match(@number).to_a
    return nil if m.nil?
    # area code may not start with 0 or 1
    return nil if %w[0 1].include?(area_code.chr)
    # exchange may not start with 0 or 1
    return nil if %w[0 1].include?(exchange.chr)

    [area_code, exchange, local].join("")
  end

  private

  def initialize(number)
    @number = number
  end

end