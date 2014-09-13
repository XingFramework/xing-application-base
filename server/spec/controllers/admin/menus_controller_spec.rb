require 'spec_helper'

describe Admin::MenusController do

  describe "GET index" do
    let :menus do
      [ double(Menu), double(Menu) ]
    end
    let :serializer do
      double Admin::MenusSerializer
    end

    it "should fetch the array of menus and pass them to a serializer" do
      expect(Menu).to receive(:list).and_return(menus)
      expect(Admin::MenusSerializer).to receive(:new).and_return(serializer)
      expect(serializer).to receive(:as_json)

      get :index
    end
  end
end
