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
  self.inheritance_column = 'layout'

  validates_presence_of :title, :url_slug
  validates_uniqueness_of :url_slug

  after_create :regenerate_sitemap
  after_update :regenerate_sitemap
  before_destroy :regenerate_sitemap

  has_many :page_contents
  has_many :content_blocks, :through => :page_contents


  scope :published, -> do
    where("(publish_start IS NULL OR publish_start < :now) AND (publish_end IS NULL OR publish_end > :now)", :now => Time.zone.now)
  end

  scope :unpublished, -> do
    where("NOT ((publish_start IS NULL OR publish_start < :now) AND (publish_end IS NULL OR publish_end > :now))", :now => Time.zone.now)
  end

  scope :most_recent, proc {|count|
    order(:updated_at => :desc).limit(count || 5)
  }

  def published?
    (publish_start.nil? || publish_start <= Time.zone.now) && (publish_end.nil? || publish_end >= Time.zone.now)
  end

  def all_associated_contents
    Hash[page_contents.map do |pc| [ pc.name, pc.content_block ] end ]
  end

  def contents
    if self.class.content_format.present?
      all_associated_contents.select{ |key, val| content_format.has_key?(key) }
    end
  end

  def regenerate_sitemap
    Sitemap.create! unless Rails.env.test?
  end
end
