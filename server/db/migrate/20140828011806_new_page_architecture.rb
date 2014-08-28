class NewPageArchitecture < ActiveRecord::Migration

  def change
    enable_extension :hstore
    remove_column :pages, :content
    remove_column :pages, :css
    remove_column :pages, :headline
    remove_column :pages, :permalink

    add_column :pages, :metadata, :hstore
    add_column :pages, :url_slug, :string
    add_column :pages, :publication_date, :datetime
    add_index  :pages, :url_slug

    rename_table :locations, :menu_items

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

    add_index :page_contents, :page_id
    add_index :page_contents, :content_block_id
  end

end
