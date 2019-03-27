FactoryGirl.define do
  factory :article do
    title 'Default title'
    body 'Default body'
    published true
    association :author

    trait :featured do
      featured true
    end

    trait :airplane_hero_image_name do
      hero_image_name 'airplane.jpg'
    end
  end
end

FactoryGirl.define do
  factory :author do
    name 'McFly'
  end
end

FactoryGirl.define do
  factory :page do
    title 'Default title'
    body 'Default body'
    published true
    association :author
  end
end
