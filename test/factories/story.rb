# This will guess the User class
FactoryBot.define do
  factory :story do
    name 'bob'
    last_used Time.now
    current true
  end
end