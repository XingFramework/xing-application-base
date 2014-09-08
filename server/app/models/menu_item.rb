
# Table name: menu_items
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  path       :string(255)
#  parent_id  :integer
#  lft        :integer
#  rgt        :integer
#  page_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'absolute_path'

class MenuItem < ActiveRecord::Base

  include AbsolutePath
  acts_as_nested_set

  belongs_to :page
  belongs_to :parent, :class_name => 'MenuItem'

  validates_presence_of :name

  #def resolved_path
    #absolute_path(page ? page.permalink : path)
  #end
end
