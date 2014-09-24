# == Schema Information
#
# Table name: documents
#
#  id                :integer          not null, primary key
#  data_file_name    :string(255)
#  data_file_size    :integer
#  data_content_type :string(255)
#  data_updated_at   :datetime
#  created_at        :datetime
#  updated_at        :datetime
#

class Document < ActiveRecord::Base

  mount_uploader :data, DocUploader, :mount_on => :data_file_name
  validates_integrity_of :data
end
