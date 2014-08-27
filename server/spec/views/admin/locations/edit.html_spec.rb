require 'spec_helper'

describe "/admin/locations/edit" do
  include LocationsHelper

  let!(:location) { FactoryGirl.create(:location)  }
  before {
    assign(:location_scope, Location.main_menu)
    assign(:location, location) }

  it "should succeed" do
    render
  end

  it "should render edit form" do
    render

    action = admin_location_path(location)
    rendered.should have_css("form[action='#{action}'][method=post]")
  end
end
