module ImageTestHelper
  def mock_proper_image(options = {})
    options.merge!(
        :data_content_type => 'image/png',
        :data_updated_at => Time.now,
        :data_file_name => '/documents/filename.png')
    mock_model(Image, options)
  end

  def mock_improper_image(options = {})
    options.merge!(
        :data_content_type => 'bad/bad',
        :data_updated_at => Time.now,
        :data_file_name => '/documents/filename.suck')
    mock_model(Image, options)
  end
end
