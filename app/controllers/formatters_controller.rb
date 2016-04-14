class FormattersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_formatter, only: [:show, :edit, :update, :destroy]

  # GET /formatters
  def index
    @formatters = Formatter.page(params[:page])
  end

  # GET /formatters/1
  def show
  end

  # GET /formatters/new
  def new
    @formatter = Formatter.new
  end

  # GET /formatters/1/edit
  def edit
  end

  # POST /formatters
  def create
    @formatter = Formatter.new(formatter_params)

    if @formatter.save
      redirect_to @formatter, notice: 'Formatter was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /formatters/1
  def update
    if @formatter.update(formatter_params)
      redirect_to @formatter, notice: 'Formatter was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /formatters/1
  def destroy
    @formatter.destroy
    redirect_to formatters_url, notice: 'Formatter was successfully destroyed.'
  end

  private

  def set_formatter
    @formatter = Formatter.find(params[:id])
  end

  def formatter_params
    params.require(:formatter).permit(:item_body, :pre, :post)
  end
end
