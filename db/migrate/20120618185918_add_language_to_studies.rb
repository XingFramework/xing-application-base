class AddLanguageToStudies < ActiveRecord::Migration
  def self.up
    add_column :studies, :language, :string
  end

  def self.down
    remove_column :studies, :language
  end
end
