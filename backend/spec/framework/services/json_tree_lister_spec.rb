require 'spec_helper'

describe JsonTreeLister do

  let (:a) { FactoryGirl.create(:menu_item, :path => "a", :name => "a") }
  let (:b) { FactoryGirl.create(:menu_item, :path => "b", :name => "b", :parent => a) }
  let (:c) { FactoryGirl.create(:menu_item, :path => "c", :name => "c", :parent => b) }
  let!(:d) { FactoryGirl.create(:menu_item, :path => "d", :name => "d", :parent => c) }
  let!(:e) { FactoryGirl.create(:menu_item, :path => "e", :name => "e", :parent => a) }
  let (:f) { FactoryGirl.create(:menu_item, :path => "f", :name => "f", :parent => a) }
  let!(:g) { FactoryGirl.create(:menu_item, :path => "g", :name => "g", :parent => f) }
  let!(:h) { FactoryGirl.create(:menu_item, :path => "h", :name => "h", :parent => f) }

  let :expected_tree do
    {
      name: "a",
      url: "a",
      children: [
        {
          name: "b",
          url: "b",
          children: [
             {
               name: "c",
               url: "c",
               children: [
                  {
                    name: "d",
                    url: "d",
                    children: []
                  }
               ]
             }
          ]
        },
        {
          name: "e",
          url: "e",
          children: []
        },
        {
          name: "f",
          url: "f",
          children: [
            {
              name: "g",
              url: "g",
              children: []
            },
            {
              name: "h",
              url: "h",
              children: []
            }
          ]
        }
      ]
    }
  end

  class SimpleNodeSerializer
    def initialize(tree_node)
      @tree_node = tree_node
    end

    attr_reader :tree_node

    def as_json
      {
        :name => tree_node.node.name,
        :url => tree_node.node.path,
        :children => tree_node.children
      }
    end
  end

  it "should produce a correct tree for a node with no childen" do
    expect(JsonTreeLister.new(d.reload.self_and_descendants, SimpleNodeSerializer).render).to eq({name: "d", url: "d", children: []})
  end

  it "should produce a correct tree for a parent of a big tree" do
    expect(JsonTreeLister.new(a.reload.self_and_descendants, SimpleNodeSerializer).render).to eq(expected_tree)
  end

end
