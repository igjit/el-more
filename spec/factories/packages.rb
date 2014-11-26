FactoryGirl.define do
  factory :package do
    sequence(:name) { |n| "package#{n}" }
    sequence(:url) { |n| "http://example.com/package#{n}" }
    repo_type 'github'
  end
end
