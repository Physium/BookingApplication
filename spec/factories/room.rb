FactoryBot.define do
  factory :room do
    name { Faker::Company.name }
    capacity { rand(4..10) }
  end
end
