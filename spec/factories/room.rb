FactoryBot.define do
  factory :room do
    name { Faker::Game.title }
    capacity { rand(4..10) }
  end
end
