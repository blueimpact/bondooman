require 'rails_helper'

RSpec.describe Shot, type: :model do
  subject { FactoryGirl.create(:shot, :with_ranking) }

  let(:attrs) {
    subject.attributes.slice(
      *%w(item_id genre_id segment_id)
    ).symbolize_keys
  }

  let(:ranking_attrs) {
    subject.ranking.attributes.slice(
      *%w(platform genre_id segment_id)
    ).symbolize_keys
  }

  let(:last_ranking) {
    ranking_attrs[:created_on] = subject.ranking.created_on - 1
    FactoryGirl.create(:ranking, ranking_attrs)
  }

  describe '#last_shot' do
    it 'returns last shot' do
      last_shot = last_ranking.shots.create(attrs)
      expect(subject.last_shot).to eq last_shot
    end

    it 'returns nil if not found' do
      expect(subject.last_shot).to eq nil
    end
  end

  describe '#last_rank' do
    it 'returns rank of last shot' do
      last_ranking.shots.create(attrs.merge(rank: 7))
      expect(subject.last_rank).to eq 7
    end

    it 'returns nil if last shot not found' do
      expect(subject.last_rank).to eq nil
    end
  end
end
