FactoryBot.define do
  factory :goal do
    association :user
    target_time { "10" }
  end
end
