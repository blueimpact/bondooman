require 'rails_helper'

RSpec.describe PublicationsController, type: :controller do
  login_user

  let(:subscription) {
    FactoryGirl.create(:subscription, user: current_user)
  }

  describe 'GET #index' do
    it 'returns http success' do
      publications =
        FactoryGirl.create_list(:publication, 2, subscription: subscription)
      get :index
      expect(assigns(:publications)).to eq publications.reverse
    end
  end

  describe 'GET #show' do
    it 'assigns the requested publication as @publication' do
      publication = FactoryGirl.create(:publication, subscription: subscription)
      get :show, { id: publication.id }
      expect(assigns(:publication)).to eq(publication)
    end
  end
end
