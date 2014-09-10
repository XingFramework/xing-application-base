class Page::Homepage < Page
  register :homepage

  validate :there_can_be_only_one

  def self.get
    Page::Homepage.first
  end

  def there_can_be_only_one
    if !self.persisted? and Page::Homepage.count > 0
      errors[:base] << "You may not create a second homepage record."
    end
    if self.url_slug != 'homepage'
      errors.add(:url_slug, "Must be the exact string 'homepage'")
    end
  end

  #class DuplicateHomepageException < Exception; end


end
