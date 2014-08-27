FactoryGirl.define do
  factory :page do
    sequence :title do |n|
      "Title for page #{n}"
    end

    sequence :permalink do |n|
      "test/auto_gen_link_url_#{n}"
    end

    published true
  end

  factory :unpublished_page, :parent => :page do
    published false
  end

  factory :blog_post, :parent => :page do
    sequence :title do |n|
      "Blog Post #{n}"
    end
    layout 'blog'
    after(:create) do |post|
      topic = FactoryGirl.create(:blog_topic)
      post.locations << topic.children.create(:name => post.title)
    end
  end
end
