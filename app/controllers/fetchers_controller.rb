class FetchersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_fetcher, only: [:show, :edit, :update, :destroy]

  # GET /fetchers
  def index
    @fetchers = Fetcher.page(params[:page])
  end

  # GET /fetchers/1
  def show
  end

  # GET /fetchers/new
  def new
    @fetcher = Fetcher.new
  end

  # GET /fetchers/1/edit
  def edit
  end

  # POST /fetchers
  def create
    @fetcher = Fetcher.new(fetcher_params)

    if @fetcher.save
      redirect_to @fetcher, notice: 'Fetcher was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /fetchers/1
  def update
    if @fetcher.update(fetcher_params)
      redirect_to @fetcher, notice: 'Fetcher was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /fetchers/1
  def destroy
    @fetcher.destroy
    redirect_to fetchers_url, notice: 'Fetcher was successfully destroyed.'
  end

  private

  def set_fetcher
    @fetcher = Fetcher.find(params[:id])
  end

  def fetcher_params
    params.require(:fetcher)
      .permit(:type, :platform, :genre_id, :segment_id, :extras)
  end
end
