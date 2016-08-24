FactoryGirl.define do
  factory :image do
    image { fixture_file_upload("spec/fixtures/img/sample.jpg", 'image/jpg') }

    trait :main_image do
      status  :main
    end

    trait :sub_image do
      status  :sub
    end
  end
end
