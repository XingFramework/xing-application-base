class AddPubDatesToPage < ActiveRecord::Migration
  def change
    add_column :pages, :publish_start, :datetime, :default => nil
    add_column :pages, :publish_end, :datetime, :default => nil

    Page.reset_column_information

    beginning_of_time = Time.at(0)
    Page.all.each do |page|
      if page.read_attribute(:published)
        page.update_attribute :publish_start, beginning_of_time
      else
        page.update_attribute :publish_end, beginning_of_time
      end
    end
  end
end
