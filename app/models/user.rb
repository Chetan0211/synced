class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  before_save :downcase_emails
  after_commit :publish_cache_expiry, on: [:create, :update, :destroy]


  def downcase_emails
    self.email = email.downcase if email.present?
    self.personal_email = personal_email.downcase if personal_email.present?
  end

  def publish_cache_expiry
    cache_key = "#{user_type}_cache_#{administration_id}"

    Rails.cache.delete(cache_key)

    Rails.cache.write(cache_key, User.where(administration_id: administration_id, user_type: user_type))
    # ActiveSupport::Notifications.instrument('user.change', administration_id: administration_id, user_type: user_type)
  end

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

  scope :teachers, ->(user) { where(administration_id: user.administration_id, user_type: "teacher") }
  scope :students, ->(user) { where(administration_id: user.administration_id, user_type: "student") }

end
