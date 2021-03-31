require_relative '../enumerables.rb'

  describe Enumerable do
    describe 'my_each method' do
    it 'yields no item when collection is empty' do
      expected = []
      [].my_each { |item| expected << item }
      expect(expected).to eq([])
    end

    it 'returns each item in array when array is NOT empty' do
      array = [1, 2, 3]
      expected = []
      array.my_each { |item| expected << item }
      expect(expected).to eq(array)
    end

    it 'returns each item in a given range' do
      expected = []
      (1..3).my_each { |item| expected << item }
      expect(expected).to eq([1, 2, 3])
    end

    it 'returns an Enumerator when block is not given' do
      expect([1, 2, 3].my_each.class).to eq(Enumerator)
    end
  end

  describe 'my_each_with_index method' do
    it 'yields no item when collection is empty' do
      expected = {}
      [].my_each_with_index { |item, index| expected[index.to_s] = item }
      expect(expected).to eq({})
    end

    it "yields each item (with it's index) in an array when array is NOT empty" do
      expected = {}
      [1, 2, 3].my_each_with_index { |item, index| expected[index.to_s] = item }
      expect(expected).to eq({ '0' => 1, '1' => 2, '2' => 3 })
    end

    it "yields each item (with it's index) in a given range" do
      expected = {}
      (1..3).my_each_with_index { |item, index| expected[index.to_s] = item }
      expect(expected).to eq({ '0' => 1, '1' => 2, '2' => 3 })
    end

    it 'returns an Enumerator when block is not given' do
      expect([1, 2, 3].my_each_with_index.class).to eq(Enumerator)
    end
  end

  describe 'my_select method' do
    it 'returns an enumerator if no block is given' do
      expect((1..5).my_select.class).to be Enumerator
    end

    it 'selects items when called on an array' do
      expect([1, 2, 3, 4].my_select &:odd?).to eq([1, 3])
    end

    it 'selects items when called on a range' do
      expect((1..5).my_select &:odd?).to eq([1, 3, 5])
    end
  end

  describe 'my_all? method' do
    it 'returns true if a block does not return false or nil' do
      expect([2, 4, 6, 8].my_all? { |num| num.even? }).to be true
    end

    it 'returns false if a block returns false' do
      expect([1, 2, 3, 4].my_all? { |num| num.even? }).to be false
    end

    it 'returns false if a block returns nil' do
      expect([1, 2, 3, nil].my_all? { |num| num }).to be false
    end

    it 'returns true if a block is not passed and collections does not contain false or nil' do
      expect([1, 2, 3].my_all?).to be true
    end

    it 'returns false if a block is not passed and collections contains false' do
      expect([1, 2, 3, false].my_all?).to be false
    end

    it 'returns false if a block is not passed and collections contains nil' do
      expect([1, 2, 3, nil].my_all?).to be false
    end

    it 'returns true when the given pattern is a class and all items are instances of a class' do
      expect(([1, 2, 3, 4].my_all? Integer)).to be true
    end

    it 'returns false when the given pattern is a class and all items are not instances of a class' do
      expect(([1, 2, 3, 4, 1.66].my_all? Integer)).to be false
    end

    it 'returns true when the given pattern is a regex and all items matches pattern' do
      expect((%w[cat mat bat].my_all? /at/)).to be true
    end

    it 'returns false when the given pattern is a regex and all items do not match the pattern' do
      expect((%w[cat mat bat mad].my_all? /at/)).to be false
    end
  end

  describe 'my_any? method' do
    it 'returns true if a block returns true' do
      expect([2, 3, 5, 7].my_any?{|num| num.even?}).to be true
    end

    it 'returns false if block returns false for all items' do
      expect([2, 4, 6, 8, 10].my_any?{|num| num.odd?}).to be false
    end

    it 'returns true if block is not passed and collections contains a non falsy item' do
      expect([1, nil, false, false].my_any?).to be true
    end

    it 'returns false if a block is not passed and collections contains only falsy items' do
      expect([nil, false, nil, false].my_any?).to be false
    end

    it 'returns true when the given pattern is a class and at least one item is an instance of the class' do
      expect([1, 2, 3, 4, 'cat'].my_any? String).to be true
    end

    it 'returns false when the given pattern is a class and none of the items is an instance of the class' do
      expect([1, 2, 3, 4, 1.66].my_any? String).to be false
    end

    it 'returns true when the given pattern is a regex and at least one item matches the pattern' do
      expect(%w[cat mat bat Ruby].my_any? /by/).to be true
    end

    it 'returns false when the given pattern is a regex and non of the items matches the pattern' do
      expect(%w[cat mat bat rat].my_any? /go/).to be false
    end
  end

  describe 'my_none? method' do
    it 'returns true if a block does not return true for any of the items' do
      expect([2, 4, 6, 8].my_none? { |num| num.odd? }).to be true
    end

    it 'returns false if a block returns true for any of the items' do
      expect([1, 2, 3, 4].my_none? {|num| num.even?}).to be false
    end

    it 'returns true if a block is not passed and collections contains only falsy values' do
      expect([nil, nil, false].my_none?).to be true
    end

    it 'returns false if a block is not passed and collections contains a truthy value' do
      expect([1, 2, 3, false].my_none?).to be false
    end

    it 'returns true when the given pattern is a class and none of the items are instances of a class' do
      expect([1, 2, 3, 4].my_none? String).to be true
    end

    it 'returns false when the given pattern is a class and at least one of the items is an instance of a class' do
      expect([1, 2, 3, 4, 1.66].my_none? Integer).to be false
    end

    it 'returns true when the given pattern is a regex and none of the items matches the pattern' do
      expect(%w[cat mat bat].my_none? /rat/).to be true
    end

    it 'returns false when the given pattern is a regex and one of the items matches the pattern' do
      expect(%w[cat mat bat mad].my_none? /bat/).to be false
    end
  end

  describe 'my_count method' do
    it 'returns 0 when called on empty collection' do
      expect([].my_count).to eq(0)
    end

    it 'returns the number of items in a non empty array' do
      expect([1, 2, 3, 4, 5, 6, 7, 8].my_count).to eq(8)
    end

    it 'returns the number of items in a range' do
      expect((1..10).my_count).to eq(10)
    end

    it 'returns the number of items that yields from a block' do
      expect((1..10).my_count { |num| num.even? }).to eq(5)
    end

    it 'returns the number equal to a given argument' do
      expect([1, 2, 3, 3, 4, 5, 3, 6, 7, 3].my_count(3)).to eq(4)
    end
  end

  describe 'my_map method' do
    it 'returns an Enumerator if block is not given' do
      expect([1, 2, 3, 4, 5].my_map.class).to be Enumerator
    end

    it 'returns empty array if block is empty' do
       expect([].my_map{|item| item}).to eq([])
    end

    it 'returns a mapped array when called on range' do
      expect((1..5).my_map{|num| num * 2}).to eq([2,4,6,8,10])
    end

    it 'returns a mapped array when called with a Proc' do
      expect([1, 2, 3, 4, 5].my_map(Proc.new {|num| num * 2 })).to eq([2, 4, 6, 8, 10])
    end
  end

  describe 'my_inject' do
    it 'returns nil when collection is empty' do
      expect([].my_inject { |accm, current| accm + current }).to be nil
    end

    it 'combines all items in an array when block is given' do
      expect(['bet', 'breathe', 'bake'].my_inject { |accm, current| (accm.length > current.length) ? accm : current }).to eq 'breathe'
    end

    it 'combines all items in a range when block is given' do
      expect((2..6).my_inject { |accm, current| accm * current }).to eq 720
    end

    it 'combines all items in a collection when block is given and initial value passed in' do
      expect([1, 3, 5, 7].my_inject(15) { |accm, current| accm + current }).to eq 31
    end

    it 'combines all items in a collection when symbol is passed in' do
      expect([1, 3, 5, 7].my_inject(:*)).to eq 105
    end

    it 'combines all items in a collection when symbol and initial value passed in' do
      expect([1, 3, 5, 7].my_inject(15, :+)).to eq 31
    end
  end
 end