FactoryGirl.define do
  factory :subscription do
    user
    formatter
    ranking_fetcher
    item_fetcher
  end
end
