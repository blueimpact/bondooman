require 'rails_helper'

RSpec.describe ItemFetchersController, type: :controller do
  login_admin

  it_behaves_like FetchersController do
    let(:item) { FactoryGirl.create(:item) }

    let(:valid_attributes) {
      {
        platform: Item::PLATFORMS.first,
        item_code: 'test.bondooman.new-item'
      }
    }

    let(:invalid_attributes) {
      { platform: nil }
    }

    let(:new_attributes) {
      {
        platform: Item::PLATFORMS.last,
        item_code: 'test.bondooman.new-item'
      }
    }
  end
end
