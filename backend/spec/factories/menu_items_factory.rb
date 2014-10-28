FactoryGirl.define do

  factory :main_menu_root, :class => MenuItem do
    name "Main Menu"
    parent nil
  end

  factory :blog_topics_root, :class => MenuItem do
    name "Blog Topics"
    parent nil
  end

  factory :menu_item do
    name 'test'
    parent Menu.main_menu
  end

  factory :menu_item_with_page, :parent => :menu_item do
    association :page
  end

  factory :menu_item_without_page, :parent => :menu_item do
    page nil
    path 'test'
  end

  factory :menu_item_with_single_child, :parent => :menu_item do
    after_create do |me|
      child = FactoryGirl.build(:menu_item)
      child.move_to_child_of(me)
    end
  end

  factory :menu_item_with_children_2_deep, :parent => :menu_item do
    after_create do |me|
      child = FactoryGirl.build(:menu_item)
      child.move_to_child_of(me)
      child.reload
      sub_child = FactoryGirl.build(:menu_item)
      sub_child.move_to_child_of(child)
    end
  end

  factory :menu_item_with_2_children_each_with_2_children,
    :parent => :menu_item do
    after_create do |me|
      2.times do
        child = FactoryGirl.build(:menu_item)
        child.move_to_child_of(me)
        2.times do
          child.reload
          sub_child = FactoryGirl.build(:menu_item)
          sub_child.move_to_child_of(child)
        end
      end
    end
  end

  factory :blog_topic, :parent => :menu_item do
    sequence :name do |n|
      "Blog Topic #{n}"
    end
    parent { FactoryGirl.build(:blog_topics_root) }
  end

end
