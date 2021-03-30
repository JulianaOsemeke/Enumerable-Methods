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
      [1, 2, 3].my_each_with_index { |item, index| expected[index.to_s] = item}
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
      expect([1,2,3,4].my_select {|num| num.odd?}).to eq([1,3])
    end
    it 'selects items when called on a range' do
      expect((1..5).my_select {|num| num.odd?}).to eq([1,3,5])
    end
  end

  describe 'my_all? method' do
    it 'returns true if a block does not return false or nil' do
      expect([2,4,6,8].my_all?{|num| num.even?}).to be true
    end
    it 'returns false if a block returns false' do
      expect([1,2,3,4].my_all?{|num| num.even?}).to be false
    end
    it 'returns false if a block returns nil' do
      expect([1,2,3,nil].my_all?{|num| num}).to be false
    end
    it 'returns true if a block is not passed and collections does not contain false or nil' do
      expect([1,2,3].my_all?).to be true
    end
    it 'returns false if a block is not passed and collections contains false' do
      expect([1,2,3,false].my_all?).to be false
    end
    it 'returns false if a block is not passed and collections contains nil' do
      expect([1,2,3,nil].my_all?).to be false
    end
    it 'returns true when the given pattern is a class and all items are instances of a class' do
      expect([1,2,3,4].my_all? Integer).to be true
    end
    it 'returns false when the given pattern is a class and all items are not instances of a class' do
      expect([1,2,3,4,1.66].my_all? Integer).to be false
    end
    it 'returns true when the given pattern is a regex and all items matches pattern' do
      expect(%w[cat mat bat].my_all? /at/).to be true
    end
    it 'returns false when the given pattern is a regex and all items do not match the pattern' do
      expect(%w[cat mat bat mad].my_all? /at/).to be false
    end
  end
end