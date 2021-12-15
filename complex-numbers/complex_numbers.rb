class ComplexNumber
  attr_reader :real, :imaginary

  def initialize(real, imaginary)
    @real = real
    @imaginary = imaginary
  end

  def -(other)
    c, d = other.a, other.b
    ComplexNumber.new(a - c, b - d )
  end

  def +(other)
    c, d = other.a, other.b
    ComplexNumber.new(a + c, b + d )
  end

  def *(other)
    c, d = other.a, other.b
    ComplexNumber.new(a*c - b*d, a*d + b*c)
  end

  def /(other)
    c, d = other.a, other.b
    # copy and paste from instructions
    r = (a * c + b * d).to_f/(c**2 + d**2)
    i = (b * c - a * d).to_f/(c**2 + d**2)
    ComplexNumber.new(r, i)
  end

  def ==(other)
    real == other.real && imaginary == other.imaginary
  end

  def abs
    Math.sqrt(a**2 + b**2)
  end

  def conjugate
    ComplexNumber.new(real, -imaginary)
  end

  def exp
    r = Math.exp(a) * Math.cos(b)
    i = Math.exp(a) * Math.sin(b).round(15)
    ComplexNumber.new(r, i)
  end

  protected

  def a
    real
  end

  def b
    imaginary
  end

end
