class HypermediaJSONMapper
  class MissingLinkException < Exception; end

  # Subclasses must define:
  #    aliases       -- for self.record
  #    record_class  -- if the mapper maps to an AR object
  #
  # Subclasses should usually define:
  #    assign_values  -- move values from JSON into the mapped AR record
  #
  # Subclasses may also want to define:
  #    find_existing_record -- for locating the underlying AR record
  #    build_new_record     -- for for instantiating a new underlying AR record
  #    map_nested_models
  #    build_errors         -- if simply copying AR errors is insufficient
  #    save                 -- if they need to save more than 1 AR record

  # When updating records, pass the locator (e.g. DB id, url_slug, or other
  # unique resource extracted from the resource path) as the second argument.
  def initialize(json, locator = nil)
    @source_json = json
    if @source_json.is_a? String
      @source_hash = JSON.parse(json).with_indifferent_access
    else
      @source_hash = @source_json
    end
    @locator = locator
  end
  attr_accessor :locator, :error_data
  attr_writer :record

  def router
    Rails.application.routes
  end

  def normalize_path(path)
    path = "/#{path}"
    path.squeeze!('/')
    path.sub!(%r{/+\Z}, '')
    path.gsub!(/(%[a-f0-9]{2})/) { $1.upcase }
    path = '/' if path == ''
    path
  end

  # This helper is used to deconstruct a URL for the purpose of extracting
  # components.  For example, menu_item_mapper uses it to extract the url_slug
  # component of a page route. We are here abusing recognize_path, which isn't
  # supposed to be used outside of tests (see
  # https://github.com/rails/rails/issues/2656), but we don't know what the
  # alternative is.
  def route_to(path)
    path = "http://#{BACKEND_SUBDOMAIN}.example.com#{normalize_path(path)}";
    router.recognize_path(path)
  end

  # Default save - subclasses might override
  def save
    perform_mapping
    unless self.errors[:data].present?
      self.record.save
    end
  end

  # Default for finding an existing record - override this *or* define
  # #record_class (e.g. `return Page`
  def find_existing_record
    @record = record_class.find(@locator)
  end

  # Default for building a new record - override this *or* define #record_class
  # (e.g. `return Page`
  def build_new_record
    @record = record_class.new
  end

  def perform_mapping
    data = unwrap_data(@source_hash)
    self.error_data = Hash.new { |hash, key| hash[key] = {} }

    assign_values(data)
    map_nested_models
    build_errors
  end

  def unwrap_data(hash)
    hash['data'].with_indifferent_access
  end

  def wrap_data(hash)
    {
      data: hash
    }
  end

  def record
    @record ||= if locator.present?
                  find_existing_record
                else
                  build_new_record
                end
  end

  def assign_values(data_hash)
    # Override in subclasses to assign needed values here
    record  # force loading or creation of the underlying DB record
    update_record
  end

  # Do nothing if there are no nested models
  # Override this method in subclass if necessary
  def map_nested_models
  end

  def build_errors
    self.add_ar_arrors(self.record)
  end

  def errors
    wrap_data(error_data)
  end

  def add_ar_arrors(object)
    object_errors = ActiveModelErrorConverter.new(object).convert
    error_data.deep_merge!(object_errors)
  end

end
