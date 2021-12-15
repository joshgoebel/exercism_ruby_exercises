class PhoneNumber
  PHONE_RE = /
    ^
    [^\d]
    *1?
    [^\d]*
    (\d{3})
    [^\d]*
    (\d{3})
    [^\d]*
    (\d{4})
    [^\d]*
    $
  /x
  private_constant :PHONE_RE

  def self.clean(number)
    PhoneNumber.new(number).clean
  end

  def clean
    m, area_code, prefix, local = PHONE_RE.match(@number).to_a
    return nil if m.nil?
    # area code may not start with 0 or 1
    return nil if %w[0 1].include?(area_code.chr)
    # prefix may not start with 0 or 1
    return nil if %w[0 1].include?(prefix.chr)

    [area_code, prefix, local].join("")
  end

  private

  def initialize(number)
    @number = number
  end

end