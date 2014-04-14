class AddSeatsLeftToStudy < ActiveRecord::Migration
  def self.up
    add_column :studies, :seats_left, :integer
  end

  def self.down
    remove_column :studies, :seats_left
  end
end
