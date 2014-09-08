# == Schema Information
#
# Table name: pages
#
#  id               :integer          not null, primary key
#  title            :string(255)
#  published        :boolean          default(TRUE), not null
#  keywords         :text
#  description      :text
#  edited_at        :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  layout           :string(255)
#  publish_start    :datetime
#  publish_end      :datetime
#  metadata         :hstore
#  url_slug         :string(255)
#  publication_date :datetime
#

require 'sitemap'

class Page < ActiveRecord::Base
  include ClassRegistry

  validates_presence_of :title, :url_slug
  validates_uniqueness_of :url_slug

  #after_create :regenerate_sitemap
  #after_update :regenerate_sitemap
  #before_destroy :regenerate_sitemap

  has_many :page_contents
  has_many :content_blocks, :through => :page_contents


  scope :published, -> do
    # TODO: Decide exactly what publication fields we are using and how
    where("(publish_start IS NULL OR publish_start < :now) AND (publish_end IS NULL OR publish_end > :now)", :now => Time.zone.now)
  end

  scope :unpublished, -> do
    # TODO: Decide exactly what publication fields we are using and how
    where("NOT ((publish_start IS NULL OR publish_start < :now) AND (publish_end IS NULL OR publish_end > :now))", :now => Time.zone.now)
  end

  scope :most_recent, proc {|count|
    order(:updated_at => :desc).limit(count || 5)
  }

  def published?
    # TODO: Decide exactly what publication fields we are using and how
    (publish_start.nil? || publish_start <= Time.zone.now) && (publish_end.nil? || publish_end >= Time.zone.now)
  end

  def all_associated_contents
    Hash[page_contents.map do |pc| [ pc.name, pc.content_block ] end ]
  end

  # subclasses override self.content_format to specify the content blocks
  # they contain.
  def self.content_format; end
  def content_format
    self.class.content_format
  end

  def contents
    conts = all_associated_contents
    if content_format.present?
      conts.select!{ |name, content_block| content_format.any?{|pc| pc[:name] == name }}
      conts.each   { |name, content_block| sanitize(name, content_block) }
    end
    conts
  end

  # TODO - probably make this a class method
  def regenerate_sitemap
    Sitemap.create! unless Rails.env.test?
  end


  def layout
    self.class.name.split("::")[1..-1].join.underscore
  end

  def to_param
    url_slug
  end

  def set_url_slug
    self.url_slug ||= title.to_slug.normalize.to_s
  end

  def named_content_format(name)
    content_format.find{ |cf| cf[:name] == name }
  end

  def sanitize(name, block)
    if (sanitizer = named_content_format(name)[:sanitize_with]).present?
      block.body = send(sanitizer, block.body)
    elsif named_content_format(name)[:content_type] == 'text/html'
      block.body = sanitize_html(block.body)
    elsif named_content_format(name)[:content_type] == 'text/css'
      block.body = sanitize_css(block.body)
    end
  end

  def sanitize_html(content, config = Sanitize::Config::RESTRICTED)
    Sanitize.fragment(content, config)
  end

  def sanitize_user_html(content)
    sanitize_html(content, USER_CONTENT_DEFAULT_SANITIZER)
  end
  def sanitize_admin_html(content)
    sanitize_html(content, ADMIN_CONTENT_DEFAULT_SANITIZER)
  end
  def sanitize_css(content, config = Sanitize::Config::RELAXED)
    Sanitize::CSS.properties(content, config)
  end

  def named_content_format(name)
    content_format.find{ |cf| cf[:name] == name }
  end

end
