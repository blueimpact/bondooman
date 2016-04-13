FactoryGirl.define do
  factory :segment do
    sequence(:label) { |i| "Segment #{i}" }
    sequence(:name) { |i| "segment#{i}" }
  end

  trait :with_segment do
    segment
  end

  trait :without_segment do
    segment nil
  end
end
