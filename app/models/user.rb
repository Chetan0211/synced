class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable

  enum user_type: {
    student: 0,
    teacher: 1,
    admin: 2,
    super_user: 3,
  }

  enum status: {
    active: 0,
    inactive: 1,
    deleted: 2,
    blocked: 3,
    banned: 4,
    pending: 5,
  }

  belongs_to :administration

end
