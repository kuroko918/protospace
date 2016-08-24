FactoryGirl.define do
  factory :comment do
    text { Faker::Lorem.sentence }
    prototype
    user
  end
end
