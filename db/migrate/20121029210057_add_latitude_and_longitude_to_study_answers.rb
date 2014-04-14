class AddLatitudeAndLongitudeToStudyAnswers < ActiveRecord::Migration
  def self.up
    add_column :study_answers, :latitude, :float
    add_column :study_answers, :longitude, :float
  end

  def self.down
    remove_column :study_answers, :longitude
    remove_column :study_answers, :latitude
  end
end
