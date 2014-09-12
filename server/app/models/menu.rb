class Menu
  attr_accessor :menu_item
  DELEGATED_METHODS = [ :name, :parent, :reload ]
  delegate(*DELEGATED_METHODS, :to => :menu_item)

  def initialize(item_or_name)
    item = case item_or_name
    when MenuItem then item_or_name
    when String   then MenuItem.roots.where(:name => item_or_name).first
    when Symbol   then MenuItem.roots.where(:name => item_or_name.to_s).first
    end

    if item.root?
      @menu_item = item
    else
      raise "Cannot instantiate Menu with a non-root MenuItem"
    end
  end

  def tree
    self.menu_item.descendants
  end

  def self.list
    wrap(MenuItem.where(:parent_id => nil))
  end

  def self.wrap(item_or_array)
    [*item_or_array].map { |mi| Menu.new(mi) }
  end
end
