class AddGreyLabelLogoToStudies < ActiveRecord::Migration
  def self.up
    add_column :studies, :logo_url, :string
  end

  def self.down
    remove_column :studies, :logo_url
  end
end
