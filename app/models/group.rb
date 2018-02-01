class Group < ApplicationRecord

  TYPE_INT_CONVERSION = { 1 => 'crew', 2 => 'friends', 3 => 'organisation' }

  belongs_to :story
end
