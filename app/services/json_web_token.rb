class JsonWebToken
  SECRET_KEY = Rails.application.credentials.jwt[:secret]

  def self.encode(payload, exp = 4.hours.from_now)
    payload[:exp] = exp.to_i
    payload[:refresh_token] = generate_refresh_token(payload[:user_id])
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new body
  rescue JWT::DecodeError => e
    raise ExceptionHandler::InvalidToken, e.message
  end

  def self.generate_refresh_token(id)
    # Here, you can store the refresh token in the database or in a more secure storage
    payload = { user_id: id, exp: 30.days.from_now.to_i }
    message_encryptor.encrypt_and_sign(JWT.encode(payload, SECRET_KEY))
  end

  def self.decode_refresh_token(token)
    jwt_token = message_encryptor.decrypt_and_verify(token)
    decoded_token = jwt_token.decode(token)
    return decoded_token[:user_id] if decoded_token
  end

  private

  def self.message_encryptor
    encryptor ||= ActiveSupport::MessageEncryptor.new(Rails.application.credentials.encryption_base_key)
    encryptor
  end

end