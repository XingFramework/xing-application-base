FactoryGirl.define do
  factory :location do
    name 'test'
  end

  factory :location_with_page, :parent => :location do
    association :page
  end

  factory :location_without_page, :parent => :location do
    page nil
    path 'test'
  end

  factory :location_with_single_child, :parent => :location do
    after_create do |me|
      child = Factory(:location)
      child.move_to_child_of(me)
    end
  end

  factory :location_with_children_2_deep, :parent => :location do
    after_create do |me|
      child = FactoryGirl.build(:location)
      child.move_to_child_of(me)
      child.reload
      sub_child = FactoryGirl.build(:location)
      sub_child.move_to_child_of(child)
    end
  end

  factory :location_with_2_children_each_with_2_children,
    :parent => :location do
    after_create do |me|
      2.times do
        child = FactoryGirl.build(:location)
        child.move_to_child_of(me)
        2.times do
          child.reload
          sub_child = FactoryGirl.build(:location)
          sub_child.move_to_child_of(child)
        end
      end
    end
  end

  factory :blog_topic, :parent => :location do
    sequence :name do |n|
      "Blog Topic #{n}"
    end
  end

end
