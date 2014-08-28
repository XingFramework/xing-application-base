class NewPageArchitecture < ActiveRecord::Migration

  def change
    enable_extension :hstore
    remove_column :pages, :content
    remove_column :pages, :css
    remove_column :pages, :headline

    rename_table :locations, :menu_items

    add_column :pages, :metadata, :hstore
    add_column :pages, :publication_date, :datetime

    create_table :content_blocks do |t|
      t.string :content_type
      t.text   :body
      t.timestamps
    end

    create_table :page_contents do |t|
      t.references :page
      t.references :content_block
      t.string     :name
      t.timestamps
    end
  end

end
