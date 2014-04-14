class UpdateUsersInBritainToEngland < ActiveRecord::Migration
  def self.up
    User.where(:country=>"britain").each do |u|
      u.country = "england"
      u.save(:validate => false)
    end

    Study.in_country("britain").each do |s|
      s.countries.delete "britain"
      s.countries.push "england"
      s.save(:validate => false)
    end
  end

  def self.down
    User.where(:country=>"england").each do |u|
      u.country = "britain"
      u.save(:validate => false)
    end

    Study.in_country("england").each do |s|
      s.countries.delete "england"
      s.countries.push "britain"
      s.save(:validate => false)
    end
  end
end
