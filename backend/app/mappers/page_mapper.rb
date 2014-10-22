class PageMapper < HypermediaJSONMapper
  attr_accessor :bad_blocks, :page, :page_layout

  def save
    extract_data
    if @locator.present?
      find_and_update
    else
      # save_new
      build
      unless self.errors[:data].present?
        self.page.save
      end
    end
  end

  #
  # Part of new error handling system
  #
  def assign_values(data_hash)
    self.page_layout = data_hash.delete('layout')
    @block_hash = data_hash.delete('contents')
    set_page_type
    self.page = @page_class.new(data_hash)
    if self.page.title || self.page.url_slug
      self.page.set_url_slug
    end
  end

  def map_nested_models
    @page_class.content_format.each do |content_block_specifier|
      block_name = content_block_specifier[:name]
      format = self.page.named_content_format(block_name)
      if @block_hash.present? && @block_hash[block_name].present?
        block_data = @block_hash[block_name]
        block_data[:data][:content_type] = format[:content_type]
        cbm = ContentBlockMapper.new(block_data)
        cbm.block_name = block_name
        cbm.page_layout = self.page_layout
        cbm.build

        self.page.page_contents << PageContent.new(
          :name => block_name,
          :content_block => cbm.content_block
        )
        error_data[:contents][block_name] = cbm.errors if cbm.errors[:data].present?
      else
        build_nested_errors(content_block_specifier, block_name)
      end
    end
  end

  def build_nested_errors(content_block_specifier, block_name)
    if content_block_specifier[:required]
      if  @block_hash[block_name].blank?
        error_data[:contents][block_name] = { :data => { :type => :required, :msg => 'This field is required.'} }
      end
    end
  end

  def build_errors
    page = self.page

    # add non-ar errors?

    unless page.valid?
      page.errors.messages.each do |ar_error|
        message = ar_error[1][0]
        self.error_data[ar_error[0]] = convert_ar_message(message)
      end
    end
  end


  #
  # older methods without new error handling
  #
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
    if self.page_layout.present?
      page_registry_key = self.page_layout.to_sym
      @page_class = Page.registry_get(page_registry_key)
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
