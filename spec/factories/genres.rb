FactoryGirl.define do
  factory :genre do
    sequence(:label) { |i| "Genre #{i}" }
    sequence(:name) { |i| "genre#{i}" }
  end

  trait :with_genre do
    genre
  end
end
