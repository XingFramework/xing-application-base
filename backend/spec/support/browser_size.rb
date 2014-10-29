module BrowserSize
  SIZES = {
    :mobile  => { :width => 320, :height => 480 },
    :small   => { :width => 550, :height => 700 },
    :medium  => { :width => 800, :height => 900 },
    :desktop => { :width => 1024, :height => 1024 }
  }

  RSpec.configure do |config|
    config.before(:each) do
      if example.metadata[:js]
        if example.metadata[:size].present?
          BrowserSize.resize_browser_window(BrowserSize::SIZES[example.metadata[:size]])
        else
          BrowserSize.resize_browser_window(BrowserSize::SIZES[:desktop])
        end
      end
    end
  end

  def self.resize_browser_window(size)
    Capybara.current_session.driver.browser.manage.window.resize_to(size[:width], size[:height])
  end

end

RSpec.configure do |config|
  config.include BrowserSize, :type => :feature
end
