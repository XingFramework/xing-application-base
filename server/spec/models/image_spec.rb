# == Schema Information
#
# Table name: images
#
#  id                 :integer          not null, primary key
#  image_file_name    :string(255)
#  image_file_size    :integer
#  image_content_type :string(255)
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

require 'spec_helper'

describe Image do
end
