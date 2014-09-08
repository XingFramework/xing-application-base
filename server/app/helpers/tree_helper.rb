module TreeHelper
  #I hate to have to comment in here but, it's tricky.
  #This method takes a list of nodes in tree-order and produces a templated
  #tree of elements without making further SQL queries
  #
  class TreeLister
    #Can we search for the partials once and cache that?
    def initialize(view, nodes, node_partial, list_partial)
      @view = view
      @nodes = nodes
      @node_partial = node_partial
      @list_partial = list_partial
      @stack = [[]]
      @path = []
    end

    def render_list(items, top_level, depth)
      @view.render :partial => @list_partial, :locals => {:items => items, :depth => depth }
    end

    def render_node(node, children, depth)
      @view.render :partial => @node_partial, :locals => { :node => node, :children => children, :depth => depth}
    end

    def pop_level
      depth = @path.length
      children = render_list(@stack.pop, false, depth)
      @stack.last << render_node(@path.pop, children, depth)
    end

    def render
      (@nodes + [nil]).each_cons(2) do |this, after|
        until @path.empty? or @path.last.is_ancestor_of?(this)
          pop_level
        end
        if after.nil? or !this.is_ancestor_of?(after)
          @stack.last << render_node(this, nil, @path.length)
        else
          @path << this
          @stack << []
        end
      end
      until @path.empty?
        pop_level
      end
      return render_list(@stack.last, true, 0).html_safe
    end
  end

  def location_tree(root_name, template_name=nil)
    home_location = Location.where(:name => root_name).first

    return "" unless home_location
    Rails.logger.debug{ "Location tree being build from #{home_location.inspect}" }

    templates = NAV_TEMPLATE_NAMES.fetch(template_name || :nav)
    list_tree(templates[:node], templates[:list], home_location.descendants.includes(:page))
  end
  alias nav_menu location_tree

  #node_partial: the Rails-style path to a partial for each node in the tree
  #list_partial: the Rails-style path to a partial for collecting the children
  #of a node into a list'
  #nodes: the list of node in tree order
  def list_tree(node_partial, list_partial, nodes)
    TreeLister.new(self, nodes, node_partial, list_partial).render
  end


  def nav_menu_link(node)
    if (loc_path(node).include?("http"))
      link_to(node.name, loc_path(node), :class => active_class(node), :target => :new)
    else
      link_to(node.name, loc_path(node), :class => active_class(node))
    end
  end
end
