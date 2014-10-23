class PageMapper < HypermediaJSONMapper
  attr_accessor :bad_blocks, :page, :page_layout

  def save
    build
    unless self.errors[:data].present?
      self.page.save
    end
  end

  def assign_values(data_hash)
    @page_data = data_hash
    self.page_layout = data_hash.delete('layout')
    @block_hash = data_hash.delete('contents')

    if @locator.present?
      find_and_update
    else
      build_new
    end
  end

  def find_and_update
    self.page = Page.find_by_url_slug(@locator)
    self.page.update_attributes(@page_data)
    set_page_type
  end

  def build_new
    set_page_type
    self.page = @page_class.new(@page_data)
    self.page.set_url_slug
  end

  def set_page_type
    if self.page_layout.present?
      page_registry_key = self.page_layout.to_sym
      @page_class = Page.registry_get(page_registry_key)
    else
      @page_class = self.page.class
    end
  end

  def map_nested_models
    return unless @block_hash.present?
    @page_class.content_format.each do |content_block_specifier|
      block_name = content_block_specifier[:name]

      if @block_hash[block_name].present?
        build_content_block(block_name)
      end

      build_nested_errors(content_block_specifier, block_name)

      unless @nested_errors > 0 || @block_data.nil?
        save_content_block(self.page, block_name, unwrap_data(@block_data) )
      end
    end
  end

  def build_content_block(block_name)
    format = self.page.named_content_format(block_name)
    @block_data = @block_hash[block_name]
    @block_data[:data][:content_type] = format[:content_type]
    @cbm = ContentBlockMapper.new(@block_data)
    @cbm.block_name = block_name
    @cbm.page_layout = self.page_layout
    @cbm.build
  end

  def save_content_block(page, block_name, block_data)
    if (content_block = page.contents[block_name]).present?
      update_content_block(content_block, block_data)
    else
      add_content_block(page, block_name, block_data)
    end
    page.sanitize(block_name, page.contents[block_name])
  end

  def update_content_block(content_block, block_data)
    content_block.update_attribute(:body, block_data[:body])
  end

  def add_content_block(page, block_name, block_data)
    page.page_contents << PageContent.new(
      :name => block_name,
      :content_block => ContentBlock.new(
        :content_type => block_data[:content_type],
        :body         => block_data[:body]
      )
    )
  end

  def build_nested_errors(content_block_specifier, block_name)
    @nested_errors = 0
    if content_block_specifier[:required]
      if  @block_hash[block_name].blank?
        error_data[:contents][block_name] = { :data => { :type => :required, :message => "This block is required: #{block_name}"} }
        @nested_errors += 1
      end

      if @cbm && @cbm.content_block.body.blank?
        error_data[:contents][block_name] = error_data[:contents][block_name] = { :data => {:body=>{:type=>:required, :message=>"can't be blank"}} }
        @nested_errors += 1
      end
    end
  end

  def build_errors
    page = self.page
    self.add_ar_arrors(page)
  end

end
