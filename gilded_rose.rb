require_relative 'item.rb'

class GildedRose
  @items = []

  def initialize
    @items = []
    @items << Item.new("+5 Dexterity Vest", 10, 20)
    @items << Item.new("Aged Brie", 2, 0)
    @items << Item.new("Elixir of the Mongoose", 5, 7)
    @items << Item.new("Sulfuras, Hand of Ragnaros", 0, 80)
    @items << Item.new("Backstage passes to a TAFKAL80ETC concert", 15, 20)
    @items << Item.new("Conjured Mana Cake", 3, 6)
  end

  def update_quality
    @items.each do |product|
      adjust_quality(product)
    end
  end

  def adjust_quality(product)
    if product.name == "Sulfuras, Hand of Ragnaros"
      return
    elsif product.name == "Aged Brie"
      if product.sell_in <= 0
        increase_quality(product, 2)
      else
        increase_quality(product, 1)
      end
    elsif product.name == "Backstage passes to a TAFKAL80ETC concert"
      if product.sell_in <= 0
        product.quality = 0
      elsif (product.sell_in < 6)
        increase_quality(product, 3)
      elsif (product.sell_in < 11)
        increase_quality(product, 2)
      else
        increase_quality(product, 1)
      end
    else
      if product.sell_in <= 0
        decrease_quality(product, 2)
      else
        decrease_quality(product, 1)
      end
    end

    product.sell_in -= 1
  end

  def increase_quality(product, n)
    product.quality = [product.quality + n, 50].min
  end

  def decrease_quality(product, n)
    product.quality = [product.quality - n, 0].max
  end

end
