class AddCustomAcceptanceToStudy < ActiveRecord::Migration
  def self.up
    add_column :studies, :acceptance_email_copy, :text
    add_column :studies, :acceptance_email_pdf, :string
  end

  def self.down
    remove_column :studies, :acceptance_email_pdf
    remove_column :studies, :acceptance_email_copy
  end
end
