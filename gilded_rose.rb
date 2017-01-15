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
      characterize_product(product)
    end
  end

  def characterize_product(product)
    brie_test(product)
    not_eq_sulfuras_1(product)
    typical_test(product)
  end

  def brie_test(product)
    if (product.name != "Aged Brie" && product.name != "Backstage passes to a TAFKAL80ETC concert")
      quality_gt_0(product)
    else
      quality_lt_50(product)
      backstage_passes(product)
    end
  end

  def not_eq_sulfuras_1(product)
    if (product.name != "Sulfuras, Hand of Ragnaros")
      product.sell_in -= 1
    end
  end

  def not_eq_sulfuras_2(product)
    if (product.name != "Sulfuras, Hand of Ragnaros")
      product.quality -= 1
    end
  end

  def quality_gt_0(product)
    if (product.quality > 0)
      not_eq_sulfuras_2(product)
    end
  end

  def quality_lt_50(product)
    if (product.quality < 50)
      product.quality += 1
    end
  end

  def sell_lt_0(product)
    if (product.sell_in < 0)
      not_eq_brie(product)
    end
  end

  def sell_lt_6(product)
    if (product.sell_in < 6)
      quality_lt_50(product)
    end
  end

  def sell_lt_11(product)
    if (product.sell_in < 11)
      quality_lt_50(product)
    end
  end



  def typical_test(product)
    sell_lt_0(product)
  end

  def not_eq_brie(product)
    if (product.name != "Aged Brie")
      not_backstage_passes(product)
    else
      quality_lt_50(product)
    end
  end

  def backstage_passes(product)
    if (product.name == "Backstage passes to a TAFKAL80ETC concert")
      sell_lt_11(product)
      sell_lt_6(product)
    end
  end

  def not_backstage_passes(product)
    if (product.name != "Backstage passes to a TAFKAL80ETC concert")
      quality_gt_0(product)
    else
      product.quality = 0
    end
  end

end
