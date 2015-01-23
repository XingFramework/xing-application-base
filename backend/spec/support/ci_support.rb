$RAW_SELENIUM_WAIT = 5
if ENV["CI_SERVER"] = "yes"
  Capybara.default_wait_time = 30
  $RAW_SELENIUM_WAIT = 30
end
