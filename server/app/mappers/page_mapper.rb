class PageMapper < HypermediaJSONMapper
  attr_accessor :bad_blocks, :page

  def save
    extract_data
    if @locator.present?
      find_and_update
    else
      save_new
    end
  end

  def find_and_update
    self.page = Page.find_by_url_slug(@locator)
    self.page.update_attributes(@page_data)
    add_or_update_contents(page, @contents_data)
    self.page.save
  end

  def save_new
    set_page_type
    self.page = @page_class.new(@page_data)
    self.page.set_url_slug

    add_or_update_contents(page, @contents_data)
    self.page.save
  end

  def extract_data
    @page_data     = unwrap_data(@source_hash)
    @layout        = @page_data.delete('layout')
    @contents_data = @page_data.delete('contents')
  end

  def set_page_type
    if @layout.present?
      page_registry_key = @layout.to_sym
      @page_class = Page.registry_get(page_registry_key)
    else
      raise MissingLayoutException.new("JSON missing layout information: #{@page_data.inspect}")
    end
  end

  def add_or_update_contents(page, contents_data)
    return unless contents_data.present?

    self.bad_blocks = []
    contents_data.each do |name, content_block_hash|
      set_content_block(page, name, unwrap_data(content_block_hash))
    end
    validate_required_blocks_present(page)
    if self.bad_blocks.present?
      # TODO: accumulate errors in JSON reply resource instead
      raise BadContentException.new("JSON contained invalid content: #{bad_blocks.inspect}")
    end
  end

  def validate_required_blocks_present(page)
    populated_blocks = page.contents.select{ |key,cb| cb.body.present?}.keys
    missing_blocks = page.required_blocks - populated_blocks
    if missing_blocks.present?
      # TODO: accumulate errors in JSON reply resource instead
      raise MissingContentException.new("Required blocks not set: #{missing_blocks.inspect}")
    end
  end

  def set_content_block(page, block_name, block_data)
    format = page.named_content_format(block_name)
    if format.present?
      if (content_block = page.contents[block_name]).present?
        update_content_block(content_block, block_data)
      else
        add_content_block(page, block_name, block_data, format)
      end
      page.sanitize(block_name, page.contents[block_name])
    else
      self.bad_blocks << { block_name => block_data['body'] }
    end
  end

  def update_content_block(content_block, block_data)
    content_block.update_attribute(:body, block_data[:body])
  end

  def add_content_block(page, block_name, block_data, format)
    page.page_contents << PageContent.new(
      :name => block_name,
      :content_block => ContentBlock.new(
        :content_type => format[:content_type],
        :body         => block_data['body']
      )
    )
  end

end
