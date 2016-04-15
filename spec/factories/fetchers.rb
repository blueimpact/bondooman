FactoryGirl.define do
  factory :fetcher do
    type Fetcher::TYPES.first
    platform_name Platform::NAMES.first
    item_code nil
    genre nil
    segment nil
    extras nil
  end

  factory :item_fetcher do
    type 'ItemFetcher'
    platform_name Platform::NAMES.first
    item_code
  end

  factory :ranking_fetcher do
    type 'RankingFetcher'
    platform_name Platform::NAMES.first
    genre
    segment
  end
end
