class ContentBlockMapper < HypermediaJSONMapper
  attr_accessor :block_name, :page_layout, :content_block

  def assign_values(data_hash)
    self.content_block = ContentBlock.new(data_hash)
  end

  def map_nested_models
    # do nothing
  end

  def build_errors
    self.error_data = {}

    content_block = self.content_block

    unless content_block.valid?
      content_block.errors.messages.each do |ar_error|
        message = ar_error[1][0]
        self.error_data[ar_error[0]] = convert_ar_message(message)
      end
    end
  end
end