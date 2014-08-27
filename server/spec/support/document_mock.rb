module DocumentTestHelper
  def mock_document(options = {})
    options.merge!(
        :data_updated_at => Time.now,
        :data_file_name => '/documents/filename.ext')
    mock_model(Document, options)
  end
end
