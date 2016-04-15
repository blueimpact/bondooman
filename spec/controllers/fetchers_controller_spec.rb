require 'rails_helper'

RSpec.describe FetchersController, type: :controller do
  login_admin

  describe 'GET #index' do
    it 'assigns all fetchers as @fetchers' do
      fetchers = [
        *FactoryGirl.create_list(:item_fetcher, 2).map(&:rebecome),
        *FactoryGirl.create_list(:ranking_fetcher, 2).map(&:rebecome)
      ]
      get :index
      expect(assigns(:fetchers)).to eq fetchers.reverse
    end
  end
end
