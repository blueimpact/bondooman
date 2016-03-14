FactoryGirl.define do
  factory :ranking do
    platform Item::PLATFORMS.first
    genre
    segment
  end
end
