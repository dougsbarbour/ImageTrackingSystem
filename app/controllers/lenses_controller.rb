class LensesController < ApplicationController
  before_action :set_lens, only: [:show, :edit, :update, :destroy]

  # GET /lens
  # GET /lens.json
  def index
    @lenses = Lens.all
  end

  # GET /lens/1
  # GET /lens/1.json
  def show
  end

  # GET /lens/new
  def new
    @lens = Lens.new
  end

  # GET /lens/1/edit
  def edit
  end

  # POST /lens
  # POST /lens.json
  def create
    @lens = Lens.new(lens_params)

    respond_to do |format|
      if @lens.save
        format.html { redirect_to @lens, notice: 'Lens was successfully created.' }
        format.json { render :show, status: :created, location: @lens }
      else
        format.html { render :new }
        format.json { render json: @lens.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lens/1
  # PATCH/PUT /lens/1.json
  def update
    respond_to do |format|
      if @lens.update(lens_params)
        format.html { redirect_to @lens, notice: 'Lens was successfully updated.' }
        format.json { render :show, status: :ok, location: @lens }
      else
        format.html { render :edit }
        format.json { render json: @len.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lens/1
  # DELETE /lens/1.json
  def destroy
    @lens.destroy
    respond_to do |format|
      format.html { redirect_to lens_index_url, notice: 'Lens was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lens
      @lens = Lens.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lens_params
      params.require(:lens).permit(:description)
    end
end
