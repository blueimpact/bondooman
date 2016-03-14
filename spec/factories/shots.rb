FactoryGirl.define do
  factory :shot do
    item
    genre
    segment
    sequence(:rank) { |i| i }
    sequence(:title) { |i| "Item #{i}" }
    sequence(:author) { |i| "Author #{i}" }
    sequence(:price) { |i| i * 100 }
    sequence(:rating) { |i| i % 5 + 1 }
    sequence(:rating_count) { |i| i * 1000 }
    sequence(:download_count) { |i| [i * 100, i * 200] }
  end
end
