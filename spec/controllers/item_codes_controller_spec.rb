require 'rails_helper'

RSpec.describe ItemCodesController, type: :controller do
  login_user

  describe 'GET #index' do
    it 'assigns all item_codes as @item_codes' do
      item_codes = FactoryGirl.create_list(:item_code, 2)
      get :index
      expect(assigns(:item_codes)).to eq item_codes
    end
  end

  describe 'GET #show' do
    it 'assigns the requested item_code as @item_code' do
      item_code = FactoryGirl.create(:item_code)
      get :show, id: item_code.id
      expect(assigns(:item_code)).to eq(item_code)
    end
  end
end
