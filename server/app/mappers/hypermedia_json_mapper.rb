class HypermediaJSONMapper

  # When updating records, pass the locator (e.g. DB id, url_slug, or other
  # unique resource extracted from the resource path) as the second argument.
  def initialize(json, locator = nil)
    @source_json = json
    @source_hash = JSON.parse(json).with_indifferent_access
    @locator = locator
  end

  def unwrap_data(hash)
    hash['data'].with_indifferent_access
  end

  def errors
    {}
  end

  class BadContentException < Exception; end
  class MissingContentException < Exception; end
  class MissingLayoutException < Exception; end
  class MissingLinkException < Exception; end
end
