# NOTE:   This task exists to create fake data for the purposes of
# demonstrating the site to a client during development.   So whatever
# scaffolds we create should get a method in here to generate some
# fake entries.   Most of it should be lipsum.

# IT SHOULD NOT CONTAIN ny data absolutely required for the site to work,
#   especially that we might need in testing.  For example, groups for 'users'
#   and 'admins' if we are using an authorization system.   Such things should
#   go in seeds.rb.
#
# Once the client has real data ... i.e. an initial set of pages and/or
# a menu/location tree, those should replace the lorem data.

class Array
  # If +number+ is greater than the size of the array, the method
  # will simply return the array itself sorted randomly
  # defaults to picking one item
  def pick(number = 1)
    if (number == 1)
      sort_by{ rand }[0]
    else
      sort_by{ rand }.slice(0...number)
    end
  end
end


namespace :db do
  namespace :sample_data do

    desc "Fill the database with sample data for demo purposes"
    task :load => [
      :environment,
      :populate_pages,
      :populate_locations,
      :populate_images,
      :populate_documents
      ]

    task :populate_pages => :environment do
      require 'populator'
      Page.delete_all
      pages = [ :about_us, :contact_us ]
      pages.each do |name|
        Page.create(
          :title => name.to_s.titleize,
          :headline => name.to_s.titleize,
          :permalink => name.to_s,
          :published => true,
          :content => Populator.paragraphs(1..5)
        )
      end
    end

    # Generate some sample locations to match the pages a
    # TODO: finish implementation once the models are created
    #
    # This can be customized on a per-client basis
    task :populate_locations => :environment do
      Location.delete_all
      LOCATIONS.each do |name, hash|
        loc = Location.new(
          :name => name
        )
        loc.page = Page.find_by_title(hash[:page].to_s.titleize) if hash[:page]
        loc.path = hash[:path] if hash[:path]
        loc.save!
      end

      LOCATIONS.each do |name, hash|
        pp "Moving #{name} to child of #{hash[:parent]} if exists"
        loc = Location.find_by_name(name)
        loc.move_to_child_of(Location.find_by_name(hash[:parent].to_s)) if hash[:parent]
      end
    end

    task :populate_images => :environment do
    end

    task :populate_documents => :environment do
    end

  end
end

# Do something sometimes (with probability p).
def sometimes(p, &block)
  yield(block) if rand <= p
end

LOCATIONS = {
  :home => { :path => '/' },
  :about   => { :page => :about_us ,   :parent => :home },
  :contact => { :page => :contact_us , :parent => :home }
}
