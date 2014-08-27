class TopicsController < ApplicationController
  layout "blog"
  def index
    @topics = Location.blog_topics
    @posts = Page.most_recent.published.blog
  end

  def show
    @topic = Location.where(:id => params["id"]).first
    @posts = @topic.descendants.map{|loc| loc.page}.compact
  end
end
