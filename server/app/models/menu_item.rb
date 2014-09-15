
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


class MenuItem < ActiveRecord::Base

  acts_as_nested_set

  belongs_to :page
  belongs_to :parent, :class_name => 'MenuItem'

  validates_presence_of :name

end
