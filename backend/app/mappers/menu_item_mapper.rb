class MenuItemMapper < HypermediaJSONMapper
  alias menu_item record
  alias menu_item= record=

  attr_accessor :parent_id

  def record_class
    MenuItem
  end

  def update_record
    attrs_hash = @menu_item_data.slice(*(@menu_item_data.keys - ["children", :children]))
    menu_item.assign_attributes(attrs_hash)
    set_link
  end

  def extract_data
    @menu_item_data = unwrap_data(@source_hash)
    if parent_id.present?
      @menu_item_data["parent_id"] = parent_id
    end
    @menu_item_type = @menu_item_data.delete('type')
    @external_path = @menu_item_data.delete('path')
    @embedded_page = @menu_item_data.delete('page')
  end

  def set_link
    if @menu_item_type == 'page'
      set_page
    elsif @menu_item_type == 'raw_url'
      set_path
    end
  end

  def set_page
    if @embedded_page.present?
      page_url = @embedded_page.with_indifferent_access[:links][:self]
      url_slug = route_to(page_url)[:url_slug]
      page = Page.find_by_url_slug(url_slug)
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
