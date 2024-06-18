class Administration::Contract::Create < ApplicationContract
  property :name
  property :email
  property :email_identifier

  validates :name, presence: {message: "Organization name can't be blank"}
  validates :name, length: { minimum: 2, maximum: 60, message: "Length must be between 2 and 60 characters" }


  validates :email, presence: {message: "Organization email can't be blank"}
  validates :email, format:{
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "Enter valid email address"
  }

  validates :email_identifier, presence: {message: "Email identifier can't be blank"}
  validates :email_identifier, format:{
    with: /\A^[a-zA-Z]+(\.[a-zA-Z]+)*\.[a-zA-Z]{2,}$\z/i,
    message: "Enter a valid email identifier"
  }

  validate :email_identifier_present?

  def email_identifier_present?
    administration = Administration.find_by(email_identifier: email_identifier)
    errors.add(:email_identifier, message: "This email identifier is already taken.") if administration.present?
  end

end
