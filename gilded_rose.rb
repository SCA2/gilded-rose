require_relative 'item.rb'

class Product < Item

  attr_reader :strategy
  attr_reader :immortal

  def initialize(name, sell_in, quality, strategy: strategy, immortal: false)
    @strategy = strategy
    @immortal = immortal
    super(name, sell_in, quality)
  end

  def self.adjust_normal
    Proc.new do |p|
      if p.sell_in <= 0
        p.adjust_quality_by(-2)
      else
        p.adjust_quality_by(-1)
      end
    end
  end

  def self.adjust_brie
    Proc.new do |p|
      if p.sell_in <= 0
        p.adjust_quality_by(2)
      else
        p.adjust_quality_by(1)
      end
    end
  end

  def self.adjust_backstage
    Proc.new do |p|
      if p.sell_in <= 0
        p.adjust_quality_by(-p.quality)
      elsif p.sell_in < 6
        p.adjust_quality_by(3)
      elsif p.sell_in < 11
        p.adjust_quality_by(2)
      else
        p.adjust_quality_by(1)
      end
    end
  end

  def self.adjust_conjured
    Proc.new do |p|
      p.adjust_quality_by(-2)
    end
  end

  def adjust_quality
    strategy.call(self) unless immortal
  end

  def adjust_sell_in
    self.sell_in -= 1 unless immortal
  end

  def adjust_quality_by(n)
    self.quality += n
    self.quality = [self.quality, 50].min
    self.quality = [self.quality, 0].max
  end
end

class GildedRose
  @items = []

  def initialize
    @items = []
    @items << Product.new("+5 Dexterity Vest", 10, 20, strategy: Product.adjust_normal)
    @items << Product.new("Aged Brie", 2, 0, strategy: Product.adjust_brie)
    @items << Product.new("Elixir of the Mongoose", 5, 7, strategy: Product.adjust_normal)
    @items << Product.new("Sulfuras, Hand of Ragnaros", 0, 80, strategy: Product.adjust_normal, immortal: true)
    @items << Product.new("Backstage passes to a TAFKAL80ETC concert", 15, 20, strategy: Product.adjust_backstage)
    @items << Product.new("Conjured Mana Cake", 3, 6, strategy: Product.adjust_conjured)
  end

  def update_quality
    @items.each do |item|
      item.adjust_quality
      item.adjust_sell_in
    end
  end
end
