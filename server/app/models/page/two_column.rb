class Page::TwoColumn < Page
  register :two_column


  def self.content_format
   [{ :name         => 'headline',
      :content_type => 'text/html',
      :sanitize_with => :sanitize_admin_html
    },
    {  :name         => 'column_one',
       :content_type => 'text/html',
       :sanitize_with => :sanitize_admin_html,
       :required     => true
    },
    {  :name         => 'column_two',
       :content_type => 'text/html',
       :sanitize_with => :sanitize_admin_html,
       :required     => true
    },
    {  :name         => 'styles',
       :content_type => 'text/css'
    }]
  end


end
