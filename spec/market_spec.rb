require './lib/item'
require './lib/vendor'
require './lib/market'

RSpec.configure do |config|
  config.formatter = :documentation
end

RSpec.describe Market do
  before(:each) do
    @market = Market.new("South Pearl Street Farmers Market")
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @vendor2 = Vendor.new("Ba-Nom-a-Nom")
    @vendor3 = Vendor.new("Palisade Peach Shack")    
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: '$0.50'})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)

    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)

    @vendor3.stock(@item1, 65) 
  end

  describe 'initialize' do
    it 'exsists' do
      expect(@market).to be_a(Market)
    end
  end

  describe 'attributes' do
    it 'has a name and can have vendors' do
      expect(@market.name).to eq("South Pearl Street Farmers Market")
      expect(@market.vendors).to eq([])
    end
  end

 describe '#add_vendor' do
    it 'can add vendors into the market vendors' do
      expect(@market.vendors).to eq([])
      @market.add_vendor(@vendor1) 
      @market.add_vendor(@vendor2) 
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
    end
  end

  describe '#vendor_names' do
    it 'can list added vendors names' do
      expect(@market.vendors).to eq([])
      expect(@market.vendor_names).to eq([])
      @market.add_vendor(@vendor1) 
      @market.add_vendor(@vendor2) 
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
      expect(@market.vendor_names).to eq(["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"])
    end
  end

  describe '#vendors_that_sell' do
    it 'can find vendors that sell a specific item' do
      expect(@market.vendors).to eq([])
      @market.add_vendor(@vendor1) 
      @market.add_vendor(@vendor2) 
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])
      expect(@market.vendors_that_sell(@item1)).to eq([@vendor1, @vendor3])
      expect(@market.vendors_that_sell(@item4)).to eq([@vendor2])
    end
  end

  describe '#total_inventory' do
    it 'can find vendors that sell a specific item' do
      expect(@market.vendors).to eq([])
      @market.add_vendor(@vendor1) 
      @market.add_vendor(@vendor2) 
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])

      expected_output = {
        @item1 => {quantity: 100, vendors: [@vendor1, @vendor3]},
        @item2 => {quantity: 7, vendors: [@vendor1]},
        @item3 => {quantity: 25, vendors: [@vendor2]},
        @item4 => {quantity: 50, vendors: [@vendor2]}
      }

      expect(@market.total_inventory).to eq(expected_output)
    end
  end

  describe '#overstocked_items' do
    it 'can identify items that are overstocked' do
      expect(@market.vendors).to eq([])
      @market.add_vendor(@vendor1) 
      @market.add_vendor(@vendor2) 
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])

      expect(@market.overstocked_items).to eq([@item1])
    end
  end

  describe '#sorted_item_list' do
    it 'returns a sorted list of unique item names' do
      expect(@market.vendors).to eq([])
      @market.add_vendor(@vendor1) 
      @market.add_vendor(@vendor2) 
      @market.add_vendor(@vendor3)
      expect(@market.vendors).to eq([@vendor1, @vendor2, @vendor3])

      expect(@market.sorted_item_list).to eq(["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"])
    end
  end
end 