class HypermediaJSONMapper
  class MissingLinkException < Exception; end

  # Subclasses must define:
  #  * aliases for self.record
  #   * save
  #   OR
  #   * assign_values
  #    * find_and_update and build_and_update
  #     OR
  #    * record_class OR find_existing and build_new
  #    * update_record

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
  attr_accessor :locator, :record, :error_data

  def router
    Rails.application.routes
  end

  def route_to(path)
    router.recognize_path(path)
  end

  # Default save - subclasses might override
  def save
    build
    unless self.errors[:data].present?
      self.record.save
    end
  end

  # Default for finding/updating existing records
  def find_and_update
    find_existing
    update_record
  end

  # Default for building/updating existing records
  def build_and_update
    build_new
    update_record
  end

  # Default for finding an existing record - override this *or* define
  # #record_class (e.g. `return Page`
  def find_existing
    self.record = record_class.find(@locator)
  end

  # Default for building a new record - override this *or* define #record_class
  # (e.g. `return Page`
  def build_new
    self.record = record_class.new
  end

  def build
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

  def assign_values(data_hash)
    # Override in subclasses to assign needed values here

    if @locator.present?
      find_and_update
    else
      build_and_update
    end
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

  ERROR_CONVERSIONS = {
    "can't be blank" => :required
  }

  def convert_ar_message(ar_message, my_message = nil)
    { :type => ERROR_CONVERSIONS[ar_message] || :unknown ,
      :message => my_message || ar_message
    }
  end

  def add_ar_arrors(object)
    unless object.valid?
      object.errors.messages.each do |ar_error|
        message = ar_error[1][0]
        self.error_data[ar_error[0]] = convert_ar_message(message)
      end
    end
  end

end