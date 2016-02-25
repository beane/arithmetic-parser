describe BinaryOperator do
  before :all do
    @plus = Plus.new
    @minus = Minus.new
    @times = Times.new
    @divide = Divide.new
    @exponent = Exponent.new
  end

  context '#operate' do
    it 'knows what plus does' do
      expect(@plus.operate(1,3)).to eq 1 + 3
      expect(@plus.operate(4,-3)).to eq 4 + (-3)
    end

    it 'knows what minus does' do
      expect(@minus.operate(1,3)).to eq 1 - 3
      expect(@minus.operate(4,-3)).to eq 4 - (-3)
    end

    it 'knows what times does' do
      expect(@times.operate(1,3)).to eq 1 * 3
      expect(@times.operate(4,-3)).to eq 4 * (-3)
    end

    it 'knows what divide does' do
      expect(@divide.operate(1.0,3)).to eq 1.0 / 3
      expect(@divide.operate(4.0,-3)).to eq 4.0 / -3
    end

    it 'knows what exponent does' do
      expect(@exponent.operate(1,3)).to eq 1 ** 3
      expect(@exponent.operate(4,-3)).to eq 4 ** -3
    end
  end

  context 'ordering' do
    it 'knows that plus and minus are equivalent' do
      expect(@plus == @minus).to be true
    end

    it 'knows that times and divide are equivalent' do
      expect(@divide == @times).to be true
    end

    it 'knows that plus and minus are less than times and divide' do
      [@plus, @minus].each do |op|
        expect(@times > op).to be true
        expect(@divide > op).to be true
      end
    end

    it 'knows that exponents have highest priority' do
      [@plus, @minus, @times, @divide].each do |op|
        expect(@exponent > op).to be true
      end
    end
  end

  context '#associativity' do
    it "knows that +, -, *, / are left-associative" do
      [@plus, @minus, @times, @divide].each do |op|
        expect(op.associativity).to eq :left
      end
    end

    it 'knows that exponents are right-associative' do
      expect(@exponent.associativity).to eq :right
    end
  end
end
