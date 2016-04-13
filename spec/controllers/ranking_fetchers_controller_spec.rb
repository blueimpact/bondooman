require 'rails_helper'

RSpec.describe RankingFetchersController, type: :controller do
  login_admin

  it_behaves_like FetchersController do
    let(:genre) { FactoryGirl.create(:genre) }

    let(:segment) { FactoryGirl.create(:segment) }

    let(:valid_attributes) {
      {
        platform: Item::PLATFORMS.first,
        genre_id: genre.id,
        segment_id: segment.id
      }
    }

    let(:invalid_attributes) {
      { platform: nil }
    }
  end
end
