FactoryGirl.define do
  factory :page do
    sequence :title do |n|
      "Title for page #{n}"
    end

    sequence :url_slug do |n|
      # "test/auto_gen_link_url_#{n}"
      "auto_gen_link_url_#{n}"
    end

    published true
  end

  trait :unpublished do
    published false
  end

  trait :pre_published do
    publish_start Time.now + 1.week
  end


  factory :one_column_page, :class => Page::OneColumn, :parent => :page do
    #layout 'OneColumnPage'

    after(:create) do |page|
      page.page_contents << PageContent.new(
        :name => :headline,
        :content_block => FactoryGirl.create(:headline)
      )
      page.page_contents << PageContent.new(
        :name => :main,
        :content_block => FactoryGirl.create(:main)
      )
      page.page_contents << PageContent.new(
        :name => :styles,
        :content_block => FactoryGirl.create(:styles)
      )
    end
  end

  factory :blog_post, :parent => :page do
    sequence :title do |n|
      "Blog Post #{n}"
    end
    layout 'blog_post'

    after(:create) do |post|
      topic = FactoryGirl.create(:blog_topic)
      post.locations << topic.children.create(:name => post.title)
    end
  end

  factory :content_block do
    content_type 'text/html'
    body         'foo bar'
  end
  factory :headline, :parent => :content_block do
    sequence(:body) {|nn| "This is headline #{nn}"}
  end
  factory :main, :parent => :content_block do
    sequence(:body) do |nn|
      "This is body content #{nn}. It has <em>really awesome</em> html content."
    end
  end
  factory :styles, :parent => :content_block do
    content_type 'text/css'
    body do
      "div { font-size: 1em; }"
    end
  end


end
