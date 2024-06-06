FactoryBot.define do
  factory :message do
    body { Faker::Lorem.sentence } # Генерация случайного текста для body
    room_id { nil }
    user
  end
end
