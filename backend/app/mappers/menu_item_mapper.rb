class MenuItemMapper < HypermediaJSONMapper
  attr_accessor :menu_item

  def save
    extract_data
    if @locator.present?
      find_and_update
    else
      save_new
    end
  end

  def find_and_update
    self.menu_item = MenuItem.find(@locator)
    self.menu_item.update_attributes(@menu_item_data)
    self.menu_item.save
  end

  def save_new
    self.menu_item = MenuItem.new(@menu_item_data)
    set_link
    self.menu_item.save
  end

  def extract_data
    @menu_item_data = unwrap_data(@source_hash)
    @menu_item_type = @menu_item_data.delete('type')
    @external_path = @menu_item_data.delete('path')
    @page_url_slug = @menu_item_data.delete('page_url_slug')
  end

  def set_link
    if @menu_item_type == 'page'
      set_page
    elsif @menu_item_type == 'raw_url'
      set_path
    end
  end

  def set_page
    if @page_url_slug.present?
      page = Page.find_by_url_slug(@page_url_slug)
      self.menu_item.page = page
    else
      raise MissingLinkException.new("Page URL not set: #{@menu_item_data.inspect}")
    end
  end

  def set_path
    if @external_path.present?
      self.menu_item.path = @external_path
    else
      raise MissingLinkException.new("External URL not set: #{@menu_item_data.inspect}")
    end
  end

end