module BrowserSize
  SIZES = {
    :mobile  => { :width => 320, :height => 480 },
    :small   => { :width => 550, :height => 700 },
    :medium  => { :width => 800, :height => 900 },
    :desktop => { :width => 1024, :height => 1024 }
  }

  RSpec.configure do |config|
    config.before(:each) do
      if RSpec.current_example.metadata[:js]
        BrowserSize.resize_browser_window(SIZES[BrowserSize.current_size])
      end
    end

    # rspec-rails 3 will no longer automatically infer an example group's spec type
    # from the file location. You can explicitly opt-in to the feature using this
    # config option.
    # To explicitly tag specs without using automatic inference, set the `:type`
    # metadata manually:
    #
    #     describe ThingsController, :type => :controller do
    #       # Equivalent to being in spec/controllers
    #     end
    config.infer_spec_type_from_file_location!
  end

  def self.resize_browser_window(size)
    Capybara.current_session.driver.browser.manage.window.resize_to(size[:width], size[:height])
  end

  def self.current_size
    (RSpec.current_example.metadata[:size] || ENV['BROWSER_SIZE'] || :desktop).to_sym
  end

end

RSpec.configure do |config|
  config.include BrowserSize, :type => :feature
end
