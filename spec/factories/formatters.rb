FactoryGirl.define do
  factory :formatter do
    sequence(:item) { |i| "Item #{i}" }
    sequence(:pre) { |i| "Pre #{i}" }
    sequence(:post) { |i| "Post #{i}" }

    trait :without_pre do
      pre nil
    end

    trait :without_post do
      post nil
    end
  end
end
