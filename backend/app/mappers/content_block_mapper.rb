class ContentBlockMapper < HypermediaJSONMapper
  attr_accessor :block_name, :page_layout, :content_block

  def assign_values(data_hash)
    self.content_block = ContentBlock.new(data_hash)
  end

  def map_nested_models
    # do nothing
  end

  def build_errors
    #there are currently no AR errors
    content_block = self.content_block
    self.add_ar_arrors(content_block)
  end
end