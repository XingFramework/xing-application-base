require 'spec_helper'

describe Admin::MenuItemsController, :pending => "mapper completion" do
 before do
    @request.env['HTTP_ACCEPT'] = 'application/json'
  end

  let :menu_item do
    double(MenuItem)
  end

  ########################################################################################
  #                                      POST CREATE
  ########################################################################################
  describe "responding to POST create" do
    it "creates a new menu item" do
    end
  end
end