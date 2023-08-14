FactoryBot.define do
  factory :user do
    clerk_id { Faker::Base.bothify('user-##?##???????#') }
  end

  trait :state_admin do
    after(:create) do |user|
      user.assignments << create(:assignment, role: create(:role, name: 'state_admin'))
    end
  end

  trait :regional_admin do
    after(:create) do |user|
      user.assignments << create(:assignment, role: create(:role, name: 'regional_admin'))
    end
  end

  trait :teacher do
    after(:create) do |user|
      user.assignments << create(:assignment, role: create(:role, name: 'teacher'))
    end
  end

  trait :parent do
    after(:create) do |user|
      user.assignments << create(:assignment, role: create(:role, name: 'parent'))
    end
  end
end

FactoryBot.define do
  factory :student do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    dob { Faker::Date.birthday(min_age: 5, max_age: 18).to_datetime }
    grade { Faker::Number.between(from: 3, to: 12) }
    email { Faker::Internet.email }
    phone_number { Faker::PhoneNumber.phone_number }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    zip_code { Faker::Address.zip_code }
    user
  end
end
