class HypermediaJSONMapper
  class BadContentException < Exception; end
  class MissingContentException < Exception; end
  class MissingLayoutException < Exception; end
  class MissingLinkException < Exception; end

  # Subclasses must define:
  #   * save
  #   OR
  #   * extract_data
  #    * find_and_update and save_new
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

  ERROR_CONVERSIONS = {
    "can't be blank" => :required
  }

  def convert_ar_message(ar_message, my_message = nil)
    { :type => ERROR_CONVERSIONS[ar_message] || :unknown ,
      :message => my_message || ar_message
    }
  end

  def router
    Rails.application.routes
  end

  def route_to(path)
    router.recognize_path(path)
  end

  # Default save - subclasses might override
  def save!
    extract_data
    if @locator.present?
      find_and_update
    else
      save_new
    end
  end

  def save
    save!
    return true
  rescue ActiveRecord::RecordInvalid
    return false
  end

  # Default for saving existing records
  def find_and_update
    find_existing
    update_record
    save_record
  end

  # Default for saving new records
  def save_new
    build_new
    update_record
    save_record
  end

  def save_record
    self.record.save!
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

  def unwrap_data(hash)
    hash['data'].with_indifferent_access
  end

  def wrap_data(hash)
    {
      data: hash
    }
  end

  def errors
    wrap_data(error_data)
  end

  def build
    data = unwrap_data(@source_hash)
    self.error_data = Hash.new { |hash, key| hash[key] = {} }

    assign_values(data)
    map_nested_models
    build_errors
  end
end
