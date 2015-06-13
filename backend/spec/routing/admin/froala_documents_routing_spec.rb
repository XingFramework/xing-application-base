require 'spec_helper'

describe Admin::FroalaDocumentsController, type: :routing do
  describe "routing" do
    it "recognizes and generates #create" do
      expect({ :post => "/admin/froala_documents" }).to route_to(:controller => "admin/froala_documents", :action => "create")
    end
  end
end
