class User < ActiveRecord::Base

  # Needed to support transition from old database schema
  self.inheritance_column = :_no_column


end
