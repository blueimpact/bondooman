require 'rails_helper'

RSpec.describe ShotsController, type: :controller do
  let(:valid_attributes) do
    {}
  end

  describe 'GET #index' do
    it 'assigns all shots as @shots' do
      shot = Shot.create! valid_attributes
      get :index
      expect(assigns(:shots)).to eq([shot])
    end
  end

  describe 'GET #show' do
    it 'assigns the requested shot as @shot' do
      shot = Shot.create! valid_attributes
      get :show, id:  shot.id
      expect(assigns(:shot)).to eq(shot)
    end
  end
end
