FactoryGirl.define do
  factory :item_code do
    platform_name Platform::NAMES.first
    sequence(:code) { |i| "item#{i}" }
  end
end
