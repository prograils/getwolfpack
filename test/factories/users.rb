FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "email_#{n}@getwolfpack.dev" }
    password '12345678abc'
  end
end
