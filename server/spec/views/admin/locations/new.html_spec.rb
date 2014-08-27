require 'spec_helper'

describe "/admin/locations/new" do
  include LocationsHelper

  before do
    assign(:location, Location.new)
    assign(:location_scope, Location.main_menu)
  end

  it "should succeed" do
    render
  end

  it "should render new form" do
    render
    rendered.should have_selector("form")
  end
end
