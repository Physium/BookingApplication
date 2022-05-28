FactoryBot.define do
  factory :booking do
    start_time { Date.today.beginning_of_day }
    end_time { start_time + 1.hour }
    title { Faker::Book.title }
    description { Faker::Hipster.paragraph_by_chars }
    room { create(:room) }
    user { create(:user) }
  end
end
