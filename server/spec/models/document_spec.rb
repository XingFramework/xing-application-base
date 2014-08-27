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

require 'spec_helper'

describe Document do
end
