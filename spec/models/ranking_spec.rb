require 'rails_helper'

RSpec.describe Ranking, type: :model do
  subject { FactoryGirl.create(:ranking) }

  describe '#last_ranking' do
    let(:attrs) {
      subject.attributes.slice(
        *%w(platform genre_id segment_id)
      ).symbolize_keys
    }

    it 'returns the latest ranking 1 day ago or older' do
      attrs[:created_on] = subject.created_on - 2
      FactoryGirl.create(:ranking, attrs)
      attrs[:created_on] = subject.created_on - 1
      ranking = FactoryGirl.create(:ranking, attrs)
      expect(subject.last_ranking).to eq ranking
    end

    it 'returns nil if not found' do
      attrs[:created_on] = subject.created_on - 1
      FactoryGirl.create(
        :ranking,
        attrs.merge(platform: (Item::PLATFORMS - [subject.platform]).first)
      )
      FactoryGirl.create(:ranking, attrs.except(:genre_id))
      FactoryGirl.create(:ranking, attrs.except(:segment_id))

      expect(subject.last_ranking).to eq nil
    end

    it 'ignores more than 7 days ago' do
      attrs[:created_on] = subject.created_on - 8
      FactoryGirl.create(:ranking, attrs)

      expect(subject.last_ranking).to eq nil
    end
  end
end
