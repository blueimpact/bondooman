FactoryGirl.define do
  factory :publication do
    subscription nil
    sequence(:body) { |i| "Body #{i}" }
  end
end
