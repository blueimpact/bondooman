class FetchersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_fetcher, only: [:show, :edit, :update, :destroy]

  helper_method :model_class

  # GET /fetchers
  # GET /item_fetchers
  # GET /ranking_fetchers
  def index
    @fetchers =
      model_class.includes(:genre, :segment, :item_code)
      .order(created_at: :desc).page(params[:page])
  end

  # GET /item_fetchers/1
  # GET /ranking_fetchers/1
  def show
  end

  # GET /item_fetchers/new
  # GET /ranking_fetchers/new
  def new
    @fetcher = model_class.new
  end

  # POST /item_fetchers
  # POST /ranking_fetchers
  def create
    @fetcher = model_class.new(fetcher_params)

    if @fetcher.save
      redirect_to @fetcher, notice: 'Fetcher was successfully created.'
    else
      flash.now[:alert] = 'Failed to create.'
      render :new
    end
  end

  # GET /item_fetchers/1/edit
  # GET /ranking_fetchers/1/edit
  def edit
  end

  # PATCH/PUT /item_fetchers/1
  # PATCH/PUT /ranking_fetchers/1
  def update
    if @fetcher.update(fetcher_params)
      redirect_to @fetcher, notice: 'Fetcher was successfully updated.'
    else
      flash.now[:alert] = 'Failed to update.'
      render :edit
    end
  end

  # DELETE /item_fetchers/1
  # DELETE /ranking_fetchers/1
  def destroy
    @fetcher.destroy
    redirect_to fetchers_url, notice: 'Fetcher was successfully destroyed.'
  end

  private

  def set_fetcher
    @fetcher = model_class.find(params[:id])
  end

  def model_class
    Fetcher
  end
end
