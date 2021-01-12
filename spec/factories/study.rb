FactoryBot.define do
  factory :study do
    association :user
    time { "1" }
    total { "2" }
  end
end