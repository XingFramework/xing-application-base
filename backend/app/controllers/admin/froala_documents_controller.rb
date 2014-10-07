class Admin::FroalaDocumentsController < Admin::AdminController
  skip_before_filter :check_format, only: [:create]

  def create
    @document = Document.new(:data => params['document'])

    if @document.save
      response = { link: @document.data.url }
      render :status => 201, :json => response, :location => admin_froala_documents_path(@document)
    else
      response = { error: @document.errors.full_messages }
      render :status => 422, :json => response
    end
  end

end
