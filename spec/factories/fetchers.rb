FactoryGirl.define do
  factory :fetcher do
    type ''
    platform Item::PLATFORMS.first
    genre nil
    segment nil
    extras nil
  end
end
