class ContentBlockSerializer < BaseSerializer
  attributes :content_type, :body

  def links
    { :self => routes.admin_content_block_path(object) }
  end
end
