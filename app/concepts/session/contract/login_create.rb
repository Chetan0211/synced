class Session::Contract::LoginCreate
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: {message: "Email can't be blank"}
  validates :email, format: {
    with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
    message: "Email is not a valid."
  }
  validates :password, presence: {message: "Password can't be blank"}

  validates :password, format:{
    with: /\A^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$\z/i,
    message: "Password is not a valid."
  }

  validate :password_confirmation

  def password_confirmation
    user = User.find_by(email: email)
    unless user&.valid_password?(password)
      errors.add(:password_validation, "Your email and password don't match")
    end
  end

end
