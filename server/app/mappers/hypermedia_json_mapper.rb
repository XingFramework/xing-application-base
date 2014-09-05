class HypermediaJSONMapper

  def initialize(json)
    @source_json = json
    @source_hash = JSON.parse(json).with_indifferent_access
  end

  def unwrap_data(hash)
    hash['data']
  end

  class BadContentException < Exception; end
end
