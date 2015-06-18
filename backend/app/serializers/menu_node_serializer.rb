class MenuNodeSerializer < Xing::Serializers::Base
  attributes :type, :name, :path, :page, :type, :children

  def node
    object.node
  end

  def name
    node.name
  end

  def filter(keys)
    if node.page.present?
      keys - [ :path ]
    else
      keys - [ :page ]
    end
  end

  def path
    node.path
  end

  def page
    if node.page
      { links: { self: routes.page_path(node.page) }}
    end
  end

  def type
    node.page ? 'page' : 'raw_url'
  end

end
