require 'rails_helper'

RSpec.describe ItemFetchersController, type: :controller do
  login_admin

  it_behaves_like FetchersController do
    let(:valid_attributes) {
      {
        platform: Item::PLATFORMS.first,
        item_code: 'test.bondooman.item'
      }
    }

    let(:invalid_attributes) {
      { platform: nil }
    }
  end
end
