class Administration < ApplicationRecord

  before_save :downcase_emails


  def downcase_emails
    self.email = email.downcase if email.present?
    self.email_identifier = email_identifier.downcase if email_identifier.present?
  end


  enum status: {
    active: 0,
    inactive: 1,
    deleted: 2,
    blocked: 3,
    banned: 4,
    pending: 5,
  }
  
  has_many :users
  has_many :chats
end
