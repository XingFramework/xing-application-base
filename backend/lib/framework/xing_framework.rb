# Yes, I Cheated and I know it.  We'll do it right when we extract this to a
# gem.
Dir[Rails.root.join("lib/framework/**/*.rb")].each {|f| require f}
