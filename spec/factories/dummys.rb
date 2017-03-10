FactoryGirl.define do
  factory :dummy do
    uuid { SecurtyRandom.uuid }
    other { Faker::ChuckNorris.fact }
  end
end
