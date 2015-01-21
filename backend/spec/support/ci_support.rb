if ENV["CI_SERVER"] = "yes"
  Capybara.default_wait_time = 30
end
