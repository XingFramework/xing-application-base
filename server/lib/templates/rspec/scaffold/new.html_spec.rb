require 'spec_helper'

describe "/<%= table_name %>/new" do
  include <%= controller_class_name %>Helper
  
  before(:each) do    
    assign(:<%= file_name %>, Factory.build(:<%= singular_name %>))
  end
  
  it "should succeed" do
    render
  end
  

  it "should render new form" do
    render
                                          
    rendered.should have_selector("form", :action => <%= table_name %>_path, :method=> 'post') do |form|   
      
<% for attribute in attributes -%><% unless attribute.name =~ /_id/ || [:datetime, :timestamp, :time, :date].index(attribute.type) -%>
      form.should have_selector('<%= attribute.input_type -%>#<%= file_name %>_<%= attribute.name %>', :name => '<%= file_name %>[<%= attribute.name %>]')
<% end -%><% end -%>
    end
  end
end


