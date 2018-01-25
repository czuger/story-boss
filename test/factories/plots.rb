FactoryBot.define do
  factory :plot do
    sequence :name do |n|
      "My plot n #{n}"
    end
  end
end
