require 'spec_helper'

describe "/<%= table_name %>/show" do
  include <%= controller_class_name %>Helper
  
  before(:each) do    
    assign(:<%= file_name %>, @<%= file_name %> = Factory(:<%= singular_name %>))
  end

  it "should succeed" do
    render
  end
end

