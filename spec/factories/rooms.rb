FactoryBot.define do
  factory :room do
    sequence(:name) { |n| "Room ##{n}" }
    association :user, factory: :user
    # association :messages, factory: :message
  end
end
