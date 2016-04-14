require 'rails_helper'

RSpec.describe RankingFetchersController, type: :controller do
  login_admin

  it_behaves_like FetchersController do
    let(:valid_attributes) {
      {
        platform: ItemCode::PLATFORMS.first,
        genre_id: FactoryGirl.create(:genre).id,
        segment_id: FactoryGirl.create(:segment).id
      }
    }

    let(:invalid_attributes) {
      { platform: nil }
    }

    let(:new_attributes) {
      {
        platform: ItemCode::PLATFORMS.last,
        genre_id: FactoryGirl.create(:genre).id,
        segment_id: FactoryGirl.create(:segment).id
      }
    }
  end
end
