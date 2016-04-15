class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_subscription, only: [:show, :edit, :update, :destroy]

  # GET /subscriptions
  def index
    @subscriptions = current_user.subscriptions.page(params[:page])
  end

  # GET /subscriptions/1
  def show
  end

  # GET /subscriptions/new
  def new
    @subscription = Subscription.new
  end

  # GET /subscriptions/1/edit
  def edit
  end

  # POST /subscriptions
  def create
    @subscription = Subscription.new(subscription_params)
    @subscription.user = current_user

    if @subscription.save
      redirect_to @subscription, notice: 'Successed to create.'
    else
      render :new
    end
  end

  # PATCH/PUT /subscriptions/1
  def update
    if @subscription.update(subscription_params)
      redirect_to @subscription, notice: 'Successed to update.'
    else
      render :edit
    end
  end

  # DELETE /subscriptions/1
  def destroy
    @subscription.destroy
    redirect_to subscriptions_url, notice: 'Successed to destroy.'
  end

  private

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    params.require(:subscription)
      .permit(:formatter_id, :ranking_fetcher_id, :item_fetcher_id)
  end
end
