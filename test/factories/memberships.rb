FactoryGirl.define do
  factory :membership do
    account
    user
    role SYSTEM_ROLES.first
  end
end
