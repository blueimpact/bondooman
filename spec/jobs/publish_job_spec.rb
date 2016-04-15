require 'rails_helper'

RSpec.describe PublishJob, type: :job do
  describe '#perform' do
    let(:subscription) { FactoryGirl.create(:subscription) }

    it 'creates publication' do
      FactoryGirl.create(
        :ranking,
        subscription.ranking_fetcher.attributes.slice(
          *%w(platform_name genre_id segment_id)
        )
      )
      expect {
        subject.perform subscription
      }.to change(Publication, :count).by(1)
    end
  end
end
