require 'spec_helper'

describe Admin::FroalaDocumentsController do
  describe "routing" do
    it "recognizes and generates #create" do
      { :post => "/admin/froala_documents" }.should route_to(:controller => "admin/froala_documents", :action => "create")
    end
  end
end
