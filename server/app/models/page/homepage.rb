class Page::Homepage < Page
  register :homepage

  def initialize
    Page::Homepage.where(:url_slug => 'homepage').first
  end



end
