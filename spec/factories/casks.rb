FactoryGirl.define do
  factory :cask do
    user nil
    sequence(:url) { |n| "http://example.com/cask#{n}" }
    sequence(:raw_url) { |n| "http://example.com/raw/cask#{n}" }
    read false
    configuration false
  end
end
