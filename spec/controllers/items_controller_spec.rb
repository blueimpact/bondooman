require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  login_user

  describe 'GET #index' do
    it 'assigns all items as @items' do
      items = FactoryGirl.create_list(:item, 2)
      get :index
      expect(assigns(:items)).to eq items
    end
  end

  describe 'GET #show' do
    it 'assigns the requested item as @item' do
      item = FactoryGirl.create(:item)
      get :show, id: item.id
      expect(assigns(:item)).to eq item
    end
  end
end
