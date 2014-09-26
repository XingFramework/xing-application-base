class MenuItemMapper < HypermediaJSONMapper
  alias menu_item record
  alias menu_item= record=

  attr_accessor :parent_id

  def record_class
    MenuItem
  end

  def update_record
    self.menu_item.assign_attributes(@menu_item_data)
    set_link
  end

  def extract_data
    @menu_item_data = unwrap_data(@source_hash)
    if parent_id.present?
      @menu_item_data["parent_id"] = parent_id
    end
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
