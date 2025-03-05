class Market
  attr_reader :name, :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor
  end

  def vendor_names
    @vendors.map do |vendor|
    vendor.name
    end
  end

  def vendors_that_sell(item)
    @vendors.select do |vendor|
      vendor.inventory[item] > 0
    end
  end

  def total_inventory
    inventory = Hash.new do |hash, key|
      hash[key] = {quantity: 0, vendors: []}
    end

    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        inventory[item][:quantity] += quantity
        inventory[item][:vendors] << vendor
      end
    end
    inventory
  end

  def overstocked_items
    total_inventory.select do |item, info|
      info[:vendors].size > 1 && info[:quantity] > 50
    end.keys
  end

  def sorted_item_list
    item_names = []

    @vendors.each do |vendor|
      inventory = vendor.inventory
      items = inventory.keys

      items.each do |item|
        item_names << item.name
      end
    end
    item_names.uniq.sort
  end
end