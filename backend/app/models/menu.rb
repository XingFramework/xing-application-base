class Menu
  attr_accessor :menu_item
  DELEGATED_METHODS = [ :name, :parent, :reload, :read_attribute_for_serialization, :id, :to_param ]
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
    self.menu_item.self_and_descendants
  end

  def self.list
    wrap(MenuItem.where(:parent_id => nil))
  end

  def self.wrap(item_or_array)
    [*item_or_array].map { |mi| Menu.new(mi) }
  end

  def self.main_menu
    MenuItem.find_or_create_by(:name => "Main Menu", :parent => nil)
  end

  def self.blog_topics
    self.new(MenuItem.find_by(:name => "Blog Topics"))
  end
end
