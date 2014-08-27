class Admin::LocationsController < Admin::AdminController
  # GET /locations
  def index
    @locations = location_scope
    @human_plural_name = human_plural_name
    @human_name = human_name
  end

  # GET /locations/new
  def new
    @location = Location.new()
    @location_scope = location_scope
    @human_name = human_name
  end

  # GET /locations/1/edit
  def edit
    @location = Location.find(params[:id])
    @location_scope = location_scope
    @human_name = human_name
  end

  # POST /locations
  def create
    @location = Location.new(location_params)

    if @location.save
      expire_locations_cache(@location)
      flash[:notice] = "#{human_name} was successfully created."
      if params[:from_page]
        redirect_to(edit_admin_page_path(:id => @location.page_id))
      else
        redirect_to(:action => :index)
      end
    else
      render :action => "new"
    end
  end


  # PUT /locations/1
  def update
    @location = Location.find(params[:id])

    expire_locations_cache(@location)
    unless (move_to = params[:location]["move_to"]).blank?
      Rails.logger.debug{"Moving [#{move_to}]: #{@location.to_text}"}
      if move_to == "last"
        @location.move_to_right_of(@location.siblings.last)
      else
        @location.move_to_left_of(move_to.to_i)
      end
      Rails.logger.debug{"Moved to #{@location.to_text}"}

      expire_locations_cache(@location)
    end

    if @location.update_attributes(location_params)
      flash[:notice] = "#{human_name} was successfully updated."
      redirect_to(:action => :index)
    else
      render :action => 'edit'
    end
  end

  # DELETE /locations/1
  def destroy
    @location = location_scope.find(params[:id])
    @location.destroy

    redirect_to(admin_locations_url)
  end

  private

  def human_plural_name
    "Menu Entries"
  end

  def human_name
    "Menu Entry"
  end

  def expire_locations_cache(location)
    location.self_and_ancestors.each do |root|
      NAV_TEMPLATE_NAMES.keys.each do |name|
        expire_fragment(:template_name => name, :root_name => root.name)
      end
    end
  end

  def location_scope
    Location.main_menu
  end

  def location_params
    params.required(:location).permit(:name, :path, :parent_id, :page_id, :parent, :page)
  end
end
