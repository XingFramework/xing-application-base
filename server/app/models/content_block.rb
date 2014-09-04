# == Schema Information
#
# Table name: content_blocks
#
#  id           :integer          not null, primary key
#  content_type :string(255)
#  body         :text
#  created_at   :datetime
#  updated_at   :datetime
#


class ContentBlock < ActiveRecord::Base
  has_many :page_contents
  has_many :pages, :through => :page_contents
end
