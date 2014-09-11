class Page::OneColumn < Page
  register :one_column


  def self.content_format
   [{ :name         => 'headline',
      :content_type => 'text/html',
      :sanitize_with => :sanitize_admin_html
    },
    {  :name         => 'main',
       :content_type => 'text/html',
       :sanitize_with => :sanitize_admin_html,
       :required     => true
    },
    {  :name         => 'styles',
       :content_type => 'text/css'
    }]
  end


end
