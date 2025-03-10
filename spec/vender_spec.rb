require './lib/item'
require './lib/vendor'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Vendor do
  before(:each) do
    @vendor = Vendor.new("Rocky Mountain Fresh")
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
  end
  describe 'initialize' do
    it 'exsists' do
      expect(@vendor).to be_a(Vendor)
    end
  end

  describe 'attributes' do
    it 'has a name and a inventory' do
      expect(@vendor.name).to eq("Rocky Mountain Fresh")
      expect(@vendor.inventory).to eq({})
    end
  end

  describe '#check_stock' do
    it 'can check stock of an item - it defaults to zero' do
      expect(@vendor.check_stock(@item1)).to eq(0)
    end
  end

  describe '#stock' do
    it 'can stock items and update inventory' do
      @vendor.stock(@item1, 30)

      expect(@vendor.inventory).to eq({@item1 => 30})
      expect(@vendor.check_stock(@item1)).to eq(30)

      @vendor.stock(@item1, 25)
      expect(@vendor.inventory).to eq({@item1 => 55})
      expect(@vendor.check_stock(@item1)).to eq(55)

      @vendor.stock(@item2, 12)
      expect(@vendor.inventory).to eq({@item1 => 55, @item2 => 12})
      expect(@vendor.check_stock(@item1)).to eq(55)
      expect(@vendor.check_stock(@item2)).to eq(12)
    end
  end

  describe '#potential_revenue' do
    it 'calculates potential revenue' do
      @vendor.stock(@item1, 30)
      @vendor.stock(@item2, 12)

    expect(@vendor.potential_revenue).to eq((30 * 0.75) + (12 * 0.5))
    end
  end
end 