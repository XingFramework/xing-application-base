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

  before do
    JsonTreeLister.should_receive(:new).with(menu_item_list, NodeSerializer).and_return(json_tree_lister)
    json_tree_lister.should_receive(:render).and_return(:rendered_tree)
  end

  describe "as_json" do
    subject :json do
      MenuSerializer.new(menu_item_list).to_json
    end

    it { is_expected.to be_present}
    it { is_expected.to have_json_path('links')}
    it { is_expected.to have_json_type(String).at_path('links/self')}
    it { is_expected.to have_json_path('data')}
    it { is_expected.to be_json_sql(rendered_tree).at('data')}
  end

end

