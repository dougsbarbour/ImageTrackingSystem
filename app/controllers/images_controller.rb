class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def initialize(*args)
    super(*args)
    @image_factory = ImageFactory.new
  end


  # GET /images
  # GET /images.json
  def index
    @images = Image.all
  end

  # GET /images/1
  # GET /images/1.json
  def show
  end

  # GET /images/new
  def new
    @image = @image_factory.new_image
  end

  # GET /images/1/edit
  def edit
  end

  # POST /images
  # POST /images.json
  def create
    @image = @image_factory.new_image(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render :show, status: :created, location: @image }
      else
        format.html { render :new }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    respond_to do |format|
      if @image.update(image_params)
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @image }
      else
        format.html { render :edit }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def remove_thumbnail
    @image = Image.find(params[:id])
    @image.thumbnail = nil
    @image.save!
    redirect_to @image, flash: {success: 'Image thumbnail has been removed.'}
  end

  def upload
    current_user.current_upload_file = params[:upload_images_file]
    current_user.save!
    @headers_in_first_row = params[:headers_in_first_row]
    if current_user.current_upload_file
      @sheets = @image_factory.fetch_sheets_from_file(current_user.current_upload_file.path)
      if @sheets.length == 1
        @sheet = @sheets.first
        fetch_headers
      end
    end
    self.save_to_session
    respond_to do |format|
      format.js {}
    end
  end

  def select_sheet
    self.restore_from_session
    @sheet = params[:sheet].first if params[:sheet]
    fetch_headers
    self.save_to_session
    respond_to do |format|
      format.js {}
    end
  end

  def map_fields
    self.restore_from_session
    @image_factory.headers_map.each_key do |column|
      unless params[column].empty?
        @image_factory.headers_map[column] = params[column].first
      end
    end
    @image_factory.create_images_from_file(current_user.current_upload_file.path, @sheet, @headers_in_first_row)
    current_user.current_upload_file = nil
    current_user.save!
    redirect_to images_url, notice: 'Images were successfully uploaded.'
  end


  def restore_from_session
    @image_factory.headers_map = session[:image_factory] ? session[:image_factory] : Hash.new
    @headers_in_first_row ||= session[:headers_in_first_row]
    @sheets ||= session[:sheets]
    @sheet ||= session[:sheet]
  end

  def save_to_session
    session[:image_factory] = @image_factory.headers_map
    session[:headers_in_first_row] = @headers_in_first_row
    session[:sheets] = @sheets
    session[:sheet] = @sheet
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:image).permit(:category_id, :id, :idSuffix, :description, :location, :description2, :dateTaken, :dateEntered, :orientation, :keywords, :notes, :lens_id, :film_id, :thumbnail, :upload_images_file, :headers_in_first_row)
  end

  def fetch_headers
    if @headers_in_first_row
      @image_factory.fetch_headers_from_file(current_user.current_upload_file.path, @sheet)
    else
      @image_factory.fetch_default_headers_from_file(current_user.current_upload_file.path, @sheet)
    end
  end

end
