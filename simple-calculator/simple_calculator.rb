# https://exercism.org/mentoring/discussions/f5dfa2eed6b340e5991006a75c84ab57
class SimpleCalculator
  private
  ALLOWED_OPERATIONS = ['+', '/', '*'].freeze
  public
  class UnsupportedOperation < StandardError
    def message
      'Operation is not supported.'
    end
  end
  class DivideByZero < ZeroDivisionError
    def message
      'Division by zero is not allowed.'
    end
  end
  def self.calculate(first_operand, second_operand, operation)
    raise UnsupportedOperation.new unless ALLOWED_OPERATIONS.include?(operation)
    raise ArgumentError unless first_operand.is_a?(Integer)
    raise ArgumentError unless second_operand.is_a?(Integer)
    begin
      result = case operation
               when '+'
                 first_operand + second_operand
               when '/'
                 first_operand / second_operand
               when '*'
                 first_operand * second_operand
               end
    rescue ZeroDivisionError => e
      return DivideByZero.new.message
    end
    "#{first_operand} #{operation} #{second_operand} = #{result}"
  end
end