class PageMapper
  def initialize(json)
    @source_json = json
    @source_hash = JSON.parse(json)
  end

  def save
    page_attributes    = @source_hash['data']
    content_attributes = page_attributes.delete('contents')
    page = Page.new(page_attributes)
    page.set_url_slug
    unless page.save
      raise "Unable to save page.  reasons: #{page.errors.inspect}"
    end
  end
end
