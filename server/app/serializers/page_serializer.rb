class PageSerializer < BaseSerializer
  attributes :title, :keywords, :description, :layout, :contents

  def contents
    hash = {}
    object.contents.each do |k,v|
      hash[k] = ContentBlockSerializer.new(v).as_json
    end
    hash
  end
end
