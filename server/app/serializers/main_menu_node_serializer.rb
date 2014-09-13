class MainMenuNodeSerializer < BaseSerializer
  attributes :name, :path, :type, :children

  def node
    object.node
  end

  def name

    node.name
  end

  def path
    node.page ? "/#{node.page.url_slug}" : node.path
  end

  def type
    node.page ? 'page' : 'raw_url'
  end

end