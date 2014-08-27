class Admin::TopicsController < Admin::LocationsController
  private

  def human_name
    "Topic"
  end

  def human_plural_name
    "Topics"
  end

  def location_scope
    Location.blog_topics
  end

  def location_params
    loc_parms = params.required(:location)

    loc_parms[:parent_id] = Location.topics_root.id
    #loc_parms[:path] = path_for(:controller => "topics", :action => "show",
    #:id => ???) - use topics_path(topic) instead

    loc_parms.permit(:name, :parent_id)
  end
end
