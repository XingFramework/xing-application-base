class Menu
  attr_accessor :menu_item

  def initialize(item)
    if item.root?
      @menu_item = item
    else
      raise "Cannot instantiate Menu with a non-root MenuItem"
    end
  end

  def self.list
    wrap(MenuItem.where(:parent_id => nil))
  end

  def self.wrap(item_or_array)
    [*item_or_array].map { |mi| Menu.new(mi) }
  end
end
