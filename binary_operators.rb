class BinaryOperator
  include Comparable
  def self.from_s(op)
    case op
    when '+'
      Plus.new
    when '-'
      Minus.new
    when '*'
      Times.new
    when '/'
      Divide.new
    when '^', '**'
      Exponent.new
    else
      raise ArgumentError.new('must provide a binary operator')
    end
  end

  def <=>(other_op)
    self.precedence <=> other_op.precedence
  end
end

class Plus < BinaryOperator
  def operate(a,b)
    a + b
  end
  def precedence; 2; end
  def to_s; '+'; end
  def associativity; :left; end
end

class Minus < BinaryOperator
  def operate(a,b)
    a - b
  end
  def precedence; 2; end
  def to_s; '-'; end
  def associativity; :left; end
end

class Times < BinaryOperator
  def operate(a,b)
    a * b
  end
  def precedence; 3; end
  def to_s; '*'; end
  def associativity; :left; end
end

class Divide < BinaryOperator
  def operate(a,b)
    a / b
  end
  def precedence; 3; end
  def to_s; '/'; end
  def associativity; :left; end
end

class Exponent < BinaryOperator
  def operate(a,b)
    a ** b
  end
  def precedence; 4; end
  def to_s; '^'; end
  def associativity; :right; end
end

