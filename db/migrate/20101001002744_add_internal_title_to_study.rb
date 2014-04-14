class AddInternalTitleToStudy < ActiveRecord::Migration
  def self.up
    add_column :studies, :internal_title, :string
  end

  def self.down
    remove_column :studies, :internal_title
  end
end
