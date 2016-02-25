require_relative './binary_operators'

# thanks wikipedia
# https://en.wikipedia.org/wiki/Shunting-yard_algorithm
def rpnify(expression)
  output_queue = []
  operator_stack = []
  tokens = expression.split(' ')

  tokens.each do |token|
    if token == '('
      operator_stack << token
    elsif token == ')'
      t = operator_stack.pop
      until t == '('
        output_queue << t
        t = operator_stack.pop
      end
    elsif %w{ + - * / ^ ** }.include?(token)
      current_op = BinaryOperator.from_s(token)
      previous_op = operator_stack.last # first in the stack
      if previous_op && previous_op.is_a?(BinaryOperator)
        if current_op.associativity == :left && current_op <= previous_op
          output_queue << operator_stack.pop 
        end
        if current_op.associativity == :right && current_op < previous_op
          output_queue << operator_stack.pop 
        end
      end
      operator_stack << current_op
    else # token is a number
      output_queue << token.to_f
    end
  end

  until operator_stack.empty? do
    next_token = operator_stack.pop
    if %w{ ( ) }.include?(next_token)
      raise ArgumentError.new('mismatched parentheses')
    end
    output_queue << next_token
  end

  output_queue
end

# https://en.wikipedia.org/wiki/Reverse_Polish_notation
def parse(expression)
  stack = []
  rpnify(expression).each do |token|
    if token.is_a?(BinaryOperator)
      op2 = stack.pop
      op1 = stack.pop
      stack << token.operate(op1,op2)
    else
      stack << token
    end
  end

  raise ArgumentError.new('mismatched parentheses') unless stack.length == 1
  stack.pop
end

if __FILE__ == $PROGRAM_NAME
  test_string = ARGV[0].strip
  p parse(test_string)
end

