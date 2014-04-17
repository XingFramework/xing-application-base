class User < ActiveRecord::Base

  # Needed to support transition from old database schema
  self.inheritance_column = :_no_column

  has_one :consumer_profile,   :class_name => Profile::Consumer
  has_one :researcher_profile, :class_name => Profile::Researcher

  def role
    @role    ||= Role.for(self)
  end
  def profile
    @profile ||= Profile.for(self)
  end

end
