require 'spec_helper'

describe MenuSerializer do
  let :rendered_tree do
    [
      {
        data: {
          name: "About",
          url: "/about",
          type: "page",
          children: []
        },
        links: {
        }
      },
      {
        data: {
          name: "Services",
          url: "/services",
          type: "services",
          children: []
        },
        links: {
        }
      }
    ]
  end

  let :json_tree_lister do
    double(JsonTreeLister)
  end

  let :menu_item_list do
    [double(MenuItem), double(MenuItem)]
  end

  let :main_menu do
    mm = double(Menu)
    mm.stub(:tree) { menu_item_list }
    mm
  end

  before do
    JsonTreeLister.should_receive(:new).with(menu_item_list, MenuNodeSerializer).and_return(json_tree_lister)
    json_tree_lister.should_receive(:render).and_return(rendered_tree)
  end

  describe "as_json" do
    subject :json do
      MenuSerializer.new(main_menu).to_json
    end

    it "should have correct JSON structure" do
      is_expected.to be_present
      is_expected.to have_json_path('links')
      is_expected.to have_json_type(String).at_path('links/self')
      is_expected.to have_json_type(String).at_path('links/admin')
      is_expected.to have_json_path('data')
      is_expected.to be_json_eql(rendered_tree.to_json).at_path('data')
    end
  end

end