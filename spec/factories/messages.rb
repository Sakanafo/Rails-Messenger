FactoryBot.define do
  factory :message do
    sequence(:id) { |n| n }  # Генерация уникального значения id
    body { Faker::Lorem.sentence }  # Генерация случайного текста для body
    created_at { Time.current }  # Установка текущего времени для created_at
    updated_at { Time.current }  # Установка текущего времени для updated_at
  end
end
