require 'rails_helper'

RSpec.describe RankingsController, type: :controller do
  login_user

  describe 'GET #latest' do
    it 'assigns latest rankings for every group as @rankings' do
      genres = FactoryGirl.create_list(:genre, 2)
      segments = FactoryGirl.create_list(:segment, 2)
      rankings = Item::PLATFORMS.product(genres, segments).map do |p, g, s|
        FactoryGirl.create_list(
          :ranking, 2, platform: p, genre: g, segment: s
        ).last
      end
      get :latest
      expect(assigns(:rankings)).to eq rankings
    end
  end

  describe 'GET #transition' do
    it 'assigns rankings for specific group as @rankings' do
      group = {
        platform: Item::PLATFORMS.first,
        genre: FactoryGirl.create(:genre),
        segment: FactoryGirl.create(:segment)
      }
      rankings = [
        FactoryGirl.create(:ranking, group.merge(created_at: 2.days.ago)),
        FactoryGirl.create(:ranking, group.merge(created_at: 1.days.ago))
      ]
      params = group.transform_values { |v| v.try(:name) || v }
      get :transition, params
      expect(assigns(:rankings)).to eq rankings.reverse
    end
  end

  describe 'GET #index' do
    it 'assigns all rankings as @rankings' do
      rankings = FactoryGirl.create_list(:ranking, 2)
      get :index
      expect(assigns(:rankings)).to eq rankings.reverse
    end
  end

  describe 'GET #show' do
    it 'assigns the requested ranking as @ranking' do
      ranking = FactoryGirl.create(:ranking)
      get :show, { id: ranking.id }
      expect(assigns(:ranking)).to eq ranking
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested ranking' do
      ranking = FactoryGirl.create(:ranking)
      expect {
        delete :destroy, { id: ranking.id }
      }.to change(Ranking, :count).by(-1)
    end

    it 'redirects to the rankings list' do
      ranking = FactoryGirl.create(:ranking)
      delete :destroy, { id: ranking.id }
      expect(response).to redirect_to(rankings_url)
    end
  end
end
