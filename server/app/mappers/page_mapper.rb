class PageMapper
  def initialize(json)
    @source_json = json
    @source_hash = JSON.parse(json).with_indifferent_access
  end

  def save
    page_attributes = @source_hash['data']
    contents_hash   = page_attributes.delete('contents')
    page = Page.new(page_attributes)
    page.set_url_slug

    add_contents(page, contents_hash)
    unless page.save
      raise "Unable to save page.  reasons: #{page.errors.inspect}"
    end
  end

  def add_contents(page, contents_hash)
    bad_blocks = []
    contents_hash.each do |name, body|
      if (format = page.named_content_format(name)).present?
        content_block = ContentBlock.new(
          :content_type => format[:content_type],
          :body         => body['data']['body']
        )
        page.page_contents << PageContent.new(
          :name => name,
          :content_block => content_block
        )
        page.sanitize(name, content_block)
      else
        bad_blocks << { name => body['data']['body'] }
      end
    end
    if bad_blocks.present?
      raise BadContentException.new("JSON contained invalid content: #{bad_blocks.inspect}")
    end
  end

  class BadContentException < Exception; end
end
