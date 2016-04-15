require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  login_user

  let(:valid_attributes) {
    {
      formatter_id: FactoryGirl.create(:formatter).id,
      ranking_fetcher_id: FactoryGirl.create(:ranking_fetcher).id
    }
  }

  let(:invalid_attributes) {
    {
      formatter_id: nil,
      ranking_fetcher_id: nil
    }
  }

  describe 'GET #index' do
    it 'assigns current_user subscriptions as @subscriptions' do
      FactoryGirl.create_list(:subscription, 2)
      subscriptions =
        FactoryGirl.create_list(:subscription, 2, user: current_user)
      get :index
      expect(assigns(:subscriptions)).to eq subscriptions
    end
  end

  describe 'GET #show' do
    it 'assigns the requested subscription as @subscription' do
      subscription = FactoryGirl.create(:subscription)
      get :show, { id: subscription.id }
      expect(assigns(:subscription)).to eq(subscription)
    end
  end

  describe 'GET #new' do
    it 'assigns a new subscription as @subscription' do
      get :new
      expect(assigns(:subscription)).to be_a_new(Subscription)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested subscription as @subscription' do
      subscription = FactoryGirl.create(:subscription)
      get :edit, { id: subscription.id }
      expect(assigns(:subscription)).to eq(subscription)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Subscription' do
        expect {
          post :create, { subscription: valid_attributes }
        }.to change(current_user.subscriptions, :count).by(1)
      end

      it 'assigns a newly created subscription as @subscription' do
        post :create, { subscription: valid_attributes }
        expect(assigns(:subscription)).to be_a(Subscription)
        expect(assigns(:subscription)).to be_persisted
      end

      it 'redirects to the created subscription' do
        post :create, { subscription: valid_attributes }
        expect(response).to redirect_to(Subscription.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved subscription as @subscription' do
        post :create, { subscription: invalid_attributes }
        expect(assigns(:subscription)).to be_a_new(Subscription)
      end

      it "re-renders the 'new' template" do
        post :create, { subscription: invalid_attributes }
        expect(response).to render_template('new')
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_formatter) { FactoryGirl.create(:formatter) }

      let(:new_ranking_fetcher) { FactoryGirl.create(:ranking_fetcher) }

      let(:new_attributes) {
        {
          formatter_id: new_formatter.id,
          ranking_fetcher_id: new_ranking_fetcher.id
        }
      }

      it 'updates the requested subscription' do
        subscription = FactoryGirl.create(:subscription)
        put :update, { id: subscription.id, subscription: new_attributes }
        subscription.reload
        expect(subscription.attributes).to include new_attributes.stringify_keys
      end

      it 'assigns the requested subscription as @subscription' do
        subscription = FactoryGirl.create(:subscription)
        put :update, { id: subscription.id, subscription: valid_attributes }
        expect(assigns(:subscription)).to eq(subscription)
      end

      it 'redirects to the subscription' do
        subscription = FactoryGirl.create(:subscription)
        put :update, { id: subscription.id, subscription: valid_attributes }
        expect(response).to redirect_to(subscription)
      end
    end

    context 'with invalid params' do
      it 'assigns the subscription as @subscription' do
        subscription = FactoryGirl.create(:subscription)
        put :update, { id: subscription.id, subscription: invalid_attributes }
        expect(assigns(:subscription)).to eq(subscription)
      end

      it "re-renders the 'edit' template" do
        subscription = FactoryGirl.create(:subscription)
        put :update, { id: subscription.id, subscription: invalid_attributes }
        expect(response).to render_template('edit')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested subscription' do
      subscription = FactoryGirl.create(:subscription)
      expect {
        delete :destroy, { id: subscription.id }
      }.to change(Subscription, :count).by(-1)
    end

    it 'redirects to the subscriptions list' do
      subscription = FactoryGirl.create(:subscription)
      delete :destroy, { id: subscription.id }
      expect(response).to redirect_to(subscriptions_url)
    end
  end
end
