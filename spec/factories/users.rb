FactoryGirl.define do
  factory :user do
    sequence(:login) { |n| "login#{n}" }
    sequence(:name) { |n| "name#{n}" }
    sequence(:url) { |n| "http://example.com/user#{n}" }
    sequence(:avatar_url) { |n| "http://example.com/avatar/#{n}" }
    followers 0
    following 0
  end
end
