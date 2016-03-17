require 'rails_helper'

RSpec.describe ShotsController, type: :controller do
  login_user

  describe 'GET #index' do
    it 'assigns all shots as @shots' do
      shots = FactoryGirl.create_list(:shot, 2)
      get :index
      expect(assigns(:shots)).to eq shots
    end
  end

  describe 'GET #show' do
    it 'assigns the requested shot as @shot' do
      shot = FactoryGirl.create(:shot)
      get :show, id: shot.id
      expect(assigns(:shot)).to eq shot
    end
  end
end
