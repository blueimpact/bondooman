FactoryGirl.define do
  factory :segment do
    sequence(:label) { |i| "Segment #{i}" }
    sequence(:name) { |i| "segment#{i}" }
  end

  trait :with_segment do
    segment
  end
end
