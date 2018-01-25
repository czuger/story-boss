# This will guess the User class
FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "fof#{n}@bar.com"
    end
    password '123456'

  end
end