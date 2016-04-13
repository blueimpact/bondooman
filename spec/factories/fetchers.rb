FactoryGirl.define do
  factory :fetcher do
    type Fetcher::TYPES.first
    platform Item::PLATFORMS.first
    genre nil
    segment nil
    extras nil
  end

  factory :item_fetcher do
    type 'ItemFetcher'
    platform Item::PLATFORMS.first
    sequence(:item_code) { |i| "test.bondooman.item-#{i}" }
  end

  factory :ranking_fetcher do
    type 'RankingFetcher'
    platform Item::PLATFORMS.first
    genre
    segment
  end
end
