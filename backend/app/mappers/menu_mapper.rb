class MenuMapper < HypermediaJSONMapper
  alias menu_root record
  alias menu_root= record=

  def initialize(json, locator=nil)
    super
    @existing_root = nil
  end
  attr_reader :existing_root

  def extract_data
    @menu_data = unwrap_data(@source_hash)
  end

  def find_existing
    super
    @existing_root = menu_root
    build_new
  end

  def record_class
    MenuItem
  end

  def menu_level(items, parent_id)
    items.each do |item_record|
      item_mapper = MenuItemMapper.new(item_record)
      item_mapper.parent_id = parent_id
      item_mapper.save!

      if item_record["data"]["children"].present?
        menu_level(item_record["data"]["children"], item_mapper.menu_item.id)
      end
    end
  end

  def save_record
  end

  def update_record
    root_mapper = MenuItemMapper.new(@source_hash, menu_root.id)
    root_mapper.menu_item = menu_root
    root_mapper.save!
    self.menu_root = root_mapper.menu_item
    menu_level(@menu_data["children"], menu_root.id)
    if existing_root
      menu_root.reload
      menu_root.children.reload
      existing_root.destroy_or_delete_descendants
      menu_root.reload
      menu_root.children.reload
      menu_root.children.each do |child|
        child.move_to_child_of(existing_root)
      end
      menu_root.delete
      self.menu_root = existing_root
    end
  end
end
