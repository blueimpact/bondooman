FactoryGirl.define do
  factory :item do
    item_code
    ranking nil
    rank nil
    sequence(:title) { |i| "Item #{i}" }
    sequence(:author) { |i| "Author #{i}" }
    sequence(:price) { |i| i * 100 }
    sequence(:rating) { |i| i % 5 + 1 }
    sequence(:rating_count) { |i| i * 1000 }
    sequence(:download_count) { |i| [i * 100, i * 200] }

    trait :with_ranking do
      ranking
      sequence(:rank) { |i| i }
    end
  end
end
