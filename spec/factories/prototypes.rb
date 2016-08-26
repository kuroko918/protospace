FactoryGirl.define do
  factory :prototype do
    title      { Faker::Name.name }
    catch_copy { Faker::Company.catch_phrase }
    concept    { Faker::Lorem.sentence }
    user

    trait :prototype_with_main_image do
      after(:create) do |prototype|
        create(:image, :main_image, prototype: prototype)
      end
    end

    trait :prototype_with_comments do
      transient do
        comments_count 1
      end
      after(:create) do |prototype, evaluator|
        prototype.comments << create_list(:comment, evaluator.comments_count)
      end
    end

    trait :prototype_with_likes do
      transient do
        likes_count 1
      end
      after(:create) do |prototype, evaluator|
        prototype.likes << create_list(:like, evaluator.likes_count)
      end
    end
  end
end
