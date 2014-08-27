require 'authenticated_system'

module ApplicationHelper
  include AuthenticatedSystem

  def admin?
    logged_in?
  end

  def loc_path(loc)
    loc.page ? "/#{loc.page.permalink}" : loc.path
  end

  def body_class
    klasses = params[:controller].split("/")
    klasses << params[:action]
    klasses << 'with_admin' if admin?
    klasses << @body_classes if @body_classes
    klasses
  end

  def add_body_class(klass)
    if @body_classes
      @body_classes << klass
    else
      @body_classes = [klass]
    end
  end

  def active_class(node)
    if request.fullpath == loc_path(node)
      loc_class = node.page ? node.page.permalink : node.name.gsub(/\s+/, "").underscore.dasherize
      'active-' + loc_class
    else
      nil
    end
  end

  def root_path?
    request.fullpath == root_path or request.fullpath == '/index'
  end

end
