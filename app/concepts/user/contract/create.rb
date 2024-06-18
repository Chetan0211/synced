class User::Contract::Create < ApplicationContract
  model :user

  property :first_name
  property :last_name
  property :email
  property :personal_email
  property :password
  property :user_type
  property :confirm_password, virtual: true



  validates :first_name, presence: {message: "First name can't be blank"}
  validates :first_name, length:{minimum:2, maximum:40, message: "Name must be between 2 and 40 characters"}


  validates :last_name, presence: {message: "Last name can't be blank"}
  validates :last_name, length:{minimum:2, maximum:40, message: "Name must be between 2 and 40 characters"}



  validates :email, presence: {message: "Email can't be blank"}

  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "Email is not a valid."
  }

  validate :email_present?

  def email_present?
    user = User.find_by(email: email)
    errors.add(:email, message: "This email is already taken.") if user.present?
  end

  validates :personal_email, presence: {message: "Email can't be blank"}

  validates :personal_email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "Personal email is not a valid."
  }


  validates :password, presence: {message: "Password can't be blank"}
  validates :password, format:{
    with: /\A^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$\z/i,
    message: "Password is not a valid."
  }

  validate :password_match

  def password_match
    if password != confirm_password
      errors.add(:confirm_password, message: "Password does not match.")
    end
  end


end
