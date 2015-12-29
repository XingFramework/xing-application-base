require 'spec_helper'
require 'rake'

describe 'db:sample_data namespace rake task',
  :vcr => { :cassette_name => "rake_task/db_sample_data_load", :allow_playback_repeats => true},
  :type => :task do

  before do
    load File.expand_path("../../../lib/tasks/sample_data.rake", __FILE__)
    Dir.glob("#{Rails.root}/lib/tasks/sample_data/*.rake").each{ |r| load(r) }
    Rake::Task.define_task(:environment)
    Rake::Task.define_task('db:seed')
  end

  it "should succeed and create reasonable data" do
    Rake::Task["db:sample_data:load"].invoke
  end
end
