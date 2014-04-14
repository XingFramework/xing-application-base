class CreateResearcherInterests < ActiveRecord::Migration
  def self.up
    create_table :researcher_interests do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :company_name

      t.timestamps
    end
  end

  def self.down
    drop_table :researcher_interests
  end
end
