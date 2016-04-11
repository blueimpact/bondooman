require 'rails_helper'

RSpec.describe Formatter, type: :model do
  subject { FactoryGirl.build(:formatter) }

  let(:shot) { FactoryGirl.create(:shot) }

  let(:ranking) { FactoryGirl.create(:ranking) }

  describe '#format_item' do
    %i(genre segment rank url title author image_url).each do |key|
      it "formats #{key}" do
        val = shot.send(key).to_s
        subject.item = "#{key}: <<#{key}>>"
        expect(subject.format_item shot).to eq "#{key}: #{val}"
      end
    end

    it 'formats last_rank' do
      subject.item = '<<last_rank>>'
      expect(shot).to receive(:last_rank) { 7 }
      expect(subject.format_item shot).to eq '7'
    end

    it 'formats price' do
      subject.item = '<<price>>'
      shot.price = 498
      expect(subject.format_item shot).to eq Formatter.number_to_currency(498)
    end

    it 'formats rating and rating_count' do
      subject.item = '<<rating>> (<<rating_count>>)'
      shot.rating = 3
      shot.rating_count = 3_142_419
      expect(subject.format_item shot).to eq '3.0 (3,142,419)'
    end

    it 'formats download_count_min and download_count_max' do
      subject.item = '<<download_count_min>> - <<download_count_max>>'
      shot.download_count_min = 1_000_000
      shot.download_count_max = 5_000_000
      expect(subject.format_item shot).to eq '1,000,000 - 5,000,000'
    end
  end

  describe '#format_ranking' do
    %i(genre segment).each do |key|
      it "formats #{key}" do
        val = ranking.send(key).to_s
        subject.pre = "#{key}: <<#{key}>>"
        expect(subject.format_ranking ranking, :pre).to eq "#{key}: #{val}"
      end
    end

    it 'formats platform' do
      subject.pre = '<<platform>>'
      ranking.platform = 'googleplay'
      expect(subject.format_ranking ranking, :pre).to eq 'GooglePlay'
      ranking.platform = 'appstore'
      expect(subject.format_ranking ranking, :pre).to eq 'AppStore'
    end

    it 'formats created_on' do
      subject.pre = '<<created_on>>'
      ranking.created_on = Date.new(2016, 4, 1)
      expect(subject.format_ranking ranking, :pre)
        .to eq I18n.l(Date.new(2016, 4, 1), format: :explicit)
    end

    it 'formats items_count' do
      subject.pre = '<<items_count>>'
      ranking.shots = FactoryGirl.create_list(:shot, 12)
      expect(subject.format_ranking ranking, :pre).to eq '12'
    end
  end
end
