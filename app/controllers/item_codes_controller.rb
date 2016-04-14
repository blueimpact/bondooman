class ItemCodesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:show]

  # GET /items
  def index
    @item_codes = ItemCode.page(params[:page])
  end

  # GET /items/1
  def show
  end

  private

  def set_item
    @item_code = ItemCode.find(params[:id])
  end
end
