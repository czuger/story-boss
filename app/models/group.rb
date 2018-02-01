class Group < ApplicationRecord

  TYPE_INT_CONVERSION = { 1 => 'crew', 2 => 'friends', 3 => 'organisation' }

  belongs_to :story
  has_and_belongs_to_many :characters
end
