FactoryGirl.define do
  factory :item do
    platform Item::PLATFORMS.first
    sequence(:code) { |i| "item#{i}" }
  end
end
