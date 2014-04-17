class Profile::Consumer < ActiveRecord::Base
  Profile.register('Consumer', self)

  belongs_to :user
end
