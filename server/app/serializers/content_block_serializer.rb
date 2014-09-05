class ContentBlockSerializer < BaseSerializer
  attributes :content_type, :body

  def links
    { :self => "/content-blocks/#{object.id}" }
  end
end
