class Administration < ApplicationRecord

  enum status: {
    active: 0,
    inactive: 1,
    deleted: 2,
    blocked: 3,
    banned: 4,
    pending: 5,
  }
  
  has_many :users
end
