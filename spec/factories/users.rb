FactoryGirl.define do
  factory :user do
    password =  Faker::Internet.password(8)
    password              password
    password_confirmation password
    email                 { Faker::Internet.email }
    name                  { Faker::Name.name }
    member                { Faker::Company.profession }
    works                 { Faker::Company.catch_phrase }
    profile               { Faker::Hacker.say_something_smart }
    avatar                { Faker::Avatar.image }
  end
end
