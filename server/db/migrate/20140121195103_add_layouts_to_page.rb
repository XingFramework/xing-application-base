class AddLayoutsToPage < ActiveRecord::Migration
  def change
    add_column :pages, :layout, :string, :default => nil
  end
end
