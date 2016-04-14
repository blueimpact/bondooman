require 'rails_helper'

RSpec.describe Item, type: :model do
  subject { FactoryGirl.create(:item, :with_ranking) }

  let(:attrs) {
    subject.attributes.slice(
      *%w(item_code_id genre_id segment_id)
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

  describe '#last_item' do
    it 'returns last item' do
      last_item = last_ranking.items.create(attrs)
      expect(subject.last_item).to eq last_item
    end

    it 'returns nil if not found' do
      expect(subject.last_item).to eq nil
    end
  end

  describe '#last_rank' do
    it 'returns rank of last item' do
      last_ranking.items.create(attrs.merge(rank: 7))
      expect(subject.last_rank).to eq 7
    end

    it 'returns nil if last item not found' do
      expect(subject.last_rank).to eq nil
    end
  end
end
