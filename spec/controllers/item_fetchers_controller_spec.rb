require 'rails_helper'

RSpec.describe ItemFetchersController, type: :controller do
  login_admin

  it_behaves_like FetchersController do
    let(:valid_attributes) {
      {
        platform: ItemCode::PLATFORMS.first,
        item_code_code: 'test.bondooman.new-item'
      }
    }

    let(:invalid_attributes) {
      { platform: nil }
    }

    let(:new_attributes) {
      {
        platform: ItemCode::PLATFORMS.last,
        item_code_code: 'test.bondooman.new-item'
      }
    }
  end
end
