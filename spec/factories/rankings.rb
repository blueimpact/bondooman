FactoryGirl.define do
  factory :ranking do
    platform Item::PLATFORMS.first
    genre
    segment

    after(:build) do |ranking, evaluator|
      if evaluator.created_at
        ranking.created_on = evaluator.created_at
      end
    end
  end

  trait :with_ranking do
    ranking
  end
end
