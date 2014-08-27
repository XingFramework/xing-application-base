require 'spec_helper'

describe TreeHelper do
  # a-+-b---c---d
  #   +-e
  #   \-f-+-g
  #       \-h
  let (:a) { FactoryGirl.create(:location, :path => "a", :name => "a") }
  let (:b) { FactoryGirl.create(:location, :path => "b", :name => "b", :parent => a) }
  let (:c) { FactoryGirl.create(:location, :path => "c", :name => "c", :parent => b) }
  let!(:d) { FactoryGirl.create(:location, :path => "d", :name => "d", :parent => c) }
  let!(:e) { FactoryGirl.create(:location, :path => "e", :name => "e", :parent => a) }
  let (:f) { FactoryGirl.create(:location, :path => "f", :name => "f", :parent => a) }
  let!(:g) { FactoryGirl.create(:location, :path => "g", :name => "g", :parent => f) }
  let!(:h) { FactoryGirl.create(:location, :path => "h", :name => "h", :parent => f) }

  it "should produce a correct tree for a node with no childen" do
    list_tree("shared/test_nav_node", "shared/test_nav_list", d.reload.descendants).should match_dom_of <<-EOD
<ul>
</ul>
    EOD
  end

  it "should produce a correct tree for a parent of a big tree" do
    list_tree("shared/test_nav_node", "shared/test_nav_list", a.reload.descendants).should match_dom_of <<-EOD
<ul>
<li>
<a href="b">b</a>
<ul>
<li>
<a href="c">c</a>
<ul>
<li>
<a href="d">d</a>
</li>

</ul>

</li>

</ul>

</li>

<li>
<a href="e">e</a>
</li>

<li>
<a href="f">f</a>
<ul>
<li>
<a href="g">g</a>
</li>

<li>
<a href="h">h</a>
</li>

</ul>

</li>

</ul>
    EOD
  end
end
