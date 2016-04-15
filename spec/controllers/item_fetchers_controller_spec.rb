require 'rails_helper'

RSpec.describe ItemFetchersController, type: :controller do
  login_admin

  it_behaves_like FetchersController do
    let(:valid_attributes) {
      {
        platform_name: Platform::NAMES.first,
        item_code_code: 'test.bondooman.new-item'
      }
    }

    let(:invalid_attributes) {
      { platform_name: nil }
    }

    let(:new_attributes) {
      {
        platform_name: Platform::NAMES.last,
        item_code_code: 'test.bondooman.new-item'
      }
    }
  end
end
