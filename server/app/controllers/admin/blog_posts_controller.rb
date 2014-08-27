class Admin::BlogPostsController < Admin::PagesController
  def create
    super

    topic = Location.find(page_params[:topic_id])
    page_location = topic.children.create(:name => page_params[:title], :page => @page)
    page_location.save!
    page_params[:location_id] = page_location.id
  end

  private

  def human_name
    "Blog Post"
  end

  def location_handling
    # A blog post *should* have exactly one Location associated, but it
    # *could* have multiple. Doesn't hurt to be conservative
    if @page.locations.present? and not @page.locations.any?{|location| location.parent.id == page_params[:topic_id]}
      @page.locations.first.move_to_child_of(page_params[:topic_id])
    end
  end

  def page_layout
    "blog"
  end

  def page_scope
    Page.blog
  end
end
