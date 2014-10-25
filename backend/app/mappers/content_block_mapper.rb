class ContentBlockMapper < HypermediaJSONMapper
  alias content_block record
  alias content_block= record=
  attr_accessor :block_name

  def record_class
    ContentBlock
  end

  def assign_values(data_hash)
    #this is just building a content block straight away to check if the data is valid, actual persistence happens in page mapper
    self.content_block = ContentBlock.new(data_hash)
  end
end