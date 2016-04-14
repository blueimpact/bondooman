FactoryGirl.define do
  factory :fetcher do
    type Fetcher::TYPES.first
    platform ItemCode::PLATFORMS.first
    item_code nil
    genre nil
    segment nil
    extras nil
  end

  factory :item_fetcher do
    type 'ItemFetcher'
    platform ItemCode::PLATFORMS.first
    item_code
  end

  factory :ranking_fetcher do
    type 'RankingFetcher'
    platform ItemCode::PLATFORMS.first
    genre
    segment
  end
end
