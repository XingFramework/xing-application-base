# == Schema Information
#
# Table name: locations
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  path       :string(255)
#  parent_id  :integer(4)
#  lft        :integer(4)
#  rgt        :integer(4)
#  page_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#
require 'absolute_path'

class Location < ActiveRecord::Base


  include AbsolutePath
  acts_as_nested_set

  belongs_to :page
  belongs_to :parent, :class_name => 'Location'

  validates_presence_of :name#, :path

  def resolved_path
    absolute_path(page ? page.permalink : path)
  end

  def self.topics_root
    find_or_create_by(:name => "Blog Topics")
  end

  scope :main_menu, -> do
    root.self_and_descendants
  end

  scope :blog_topics, -> do
    children_of(topics_root.id)
  end
end
