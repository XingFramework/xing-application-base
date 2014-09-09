class MainMenuNodeSerializer < BaseSerializer
  attributes :name, :url, :type, :children

  def node
    object.node
  end

  def name

    node.name
  end

  def url
    node.page ? "/#{node.page.url_slug}" : node.path
  end

  def type
    node.page ? 'page' : 'raw_url'
  end

end