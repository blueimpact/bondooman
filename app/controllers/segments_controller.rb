class SegmentsController < ApplicationController
  before_action :set_segment, only: [:show, :edit, :update, :destroy]

  # GET /segments
  def index
    @segments = Segment.page(params[:page])
  end

  # GET /segments/1
  def show
  end

  # GET /segments/new
  def new
    @segment = Segment.new
  end

  # GET /segments/1/edit
  def edit
  end

  # POST /segments
  def create
    @segment = Segment.new(segment_params)

    if @segment.save
      redirect_to @segment, notice: 'Segment was successfully created.'
    else
      flash.now[:alert] = 'Failed to create.'
      render :new
    end
  end

  # PATCH/PUT /segments/1
  def update
    if @segment.update(segment_params)
      redirect_to @segment, notice: 'Segment was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update.'
      render :edit
    end
  end

  # DELETE /segments/1
  def destroy
    @segment.destroy
    redirect_to segments_url, notice: 'Segment was successfully destroyed.'
  end

  private

  def set_segment
    @segment = Segment.find(params[:id])
  end

  def segment_params
    params.require(:segment).permit(:label, :name)
  end
end
