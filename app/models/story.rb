class Story < ApplicationRecord
  belongs_to :user

  has_many :places, dependent: :destroy
  has_many :characters, dependent: :destroy
  has_many :plots, dependent: :destroy
end
