class ItemsController < ApplicationController
  before_action :set_item, only: [:show]

  # GET /items
  def index
    @items = Item.all
  end

  # GET /items/1
  def show
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end
end
