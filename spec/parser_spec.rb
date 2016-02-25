describe 'parser' do
  context 'addition' do
    it 'adds' do
      expect(parse('2 + 5')).to eq(7)
      expect(parse('9 + 5')).to eq(14)
    end

    it 'adds more than 2 numbers' do
      expect(parse('9 + 0 + 1 + 8')).to eq(18)
      expect(parse('4 + 0 + 1 + 2')).to eq(7)
    end

    it 'doesn\'t care about ordering' do
      expect(parse('9 + 0 + 1 + 8')).to eq(parse('8 + 1 + 0 + 9'))
      expect(parse('2 + 3')).to eq(parse('3 + 2'))
    end
  end

  context 'subtraction' do
    it 'subtracts' do
      expect(parse('2 - 8')).to eq(-6)
      expect(parse('8 - 2')).to eq(6)
    end

    it 'subtracts more than 2 numbers' do
      expect(parse('2 - 8 - 9')).to eq(-15)
      expect(parse('11 - 1 - 2')).to eq(8)
    end

    it 'subtracts and adds' do
      expect(parse('2 - 8 - 9 + 15 + 99')).to eq(99)
      expect(parse('2 - 8 - 9 + 99')).to eq(84)
    end

    it 'interprets ordering' do
      expect(parse('9 - 0 - 1 - 8')).to eq(0)
      expect(parse('8 - 1 - 0 - 9')).to eq -2
      expect(parse('2 - 3')).to eq -1
      expect(parse('3 - 2')).to eq 1
    end
  end

  context 'multiplication' do
    it 'multiplies' do
      expect(parse('2 * 8')).to eq 16
      expect(parse('7 * 9')).to eq 63
    end

    it 'multiplies more than 2 numbers' do
      expect(parse('19 * 2 * 4')).to eq 152
      expect(parse('2 * 3 * 1 * 5')).to eq 30
    end

    it 'doesn\'t care about ordering' do
      expect(parse('19 * 2 * 4')).to eq(parse('2 * 19 * 4'))
      expect(parse('5 * 7')).to eq(parse('7 * 5'))
    end
  end

  context 'division' do
    it 'divides' do
      expect(parse('2 / 3')).to eq(2.0/3)
      expect(parse('4 / 2')).to eq(2)
    end

    it 'divides more than 2 numbers' do
      expect(parse('5 / 2 / 1 / 8')).to eq(2.5/8)
      expect(parse('3 / 4 / 9')).to eq((3.to_f/4) / 9)
    end

    it 'interprets ordering' do
      expect(parse('2 / 3')).to eq(2.0 / 3)
      expect(parse('3 / 2')).to eq(3.0 / 2)
    end
  end

  context 'exponentiation' do
    it 'exponentiates' do
      expect(parse('2 ^ 3')).to eq 8
      expect(parse('5 ^ 3')).to eq 125
      expect(parse('2 ** 3')).to eq 8
      expect(parse('5 ** 3')).to eq 125
    end

    it 'exponentiates more than 2 numbers' do
      expect(parse('2 ^ 3 ^ 2')).to eq 512
      expect(parse('2 ^ 5 ^ 2')).to eq 33554432
      expect(parse('2 ** 3 ** 2')).to eq 512
      expect(parse('2 ** 5 ** 2')).to eq 33554432
    end
  end

  context 'complex statements' do
    it 'knows about order of operations' do
      expect(parse('2 + 3 / 5')).to eq(2 + 3.0 / 5)
      expect(parse('2 + 3 * 5')).to eq(2 + 3 * 5)
    end

    it 'knows about parentheses' do
      expect(parse('2 * ( 3 + 19 )')).to eq(2 * (3 + 19))
      expect(parse('( 8 - 3 ) ** ( 3 + 19 )')).to eq(( 8 - 3 ) ** ( 3 + 19 ))
    end
  end

  context 'rpn conversion' do
    it 'converts strings to rpn format' do
      minus = BinaryOperator.from_s('-')
      plus = BinaryOperator.from_s('+')
      exponent = BinaryOperator.from_s('^')
      rpn = [8, 3, minus, 3, 19, plus, exponent]
      expect(rpnify('( 8 - 3 ) ** ( 3 + 19 )')).to eq rpn
    end
  end
end

