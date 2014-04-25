class ScreenerQuestion < ActiveRecord::Base
  belongs_to :study
  serialize :options

  # TODO: do a better implementation of enum, maybe even ENUM in the DB.
  TYPE_SINGLE = 0
  TYPE_MULTIPLE = 1
  TYPE_OPEN = 2
  TYPE_NAMES = {
    TYPE_SINGLE => "Single",
    TYPE_MULTIPLE => "Multiple",
    TYPE_OPEN => "Open"
  }

end
