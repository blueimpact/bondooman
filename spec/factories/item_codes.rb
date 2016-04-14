FactoryGirl.define do
  factory :item_code do
    platform ItemCode::PLATFORMS.first
    sequence(:code) { |i| "item#{i}" }
  end
end
