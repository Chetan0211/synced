class Session::Create < Trailblazer::Operation
  step :model!
  step :validate
  step :create_session

  def model!(results, login_user:, **)
    results[:model] = Session::Contract::LoginCreate.new(login_user.to_h)
  end

  def validate(results, **)
    results[:model].valid?
  end

  def create_session(results, session:, **)
    user = User.find_by(email: results[:model].email)
    results[:user] = user
    session[:user_id] = user.id
    session[:session_token] = JsonWebToken.encode(
      user_id: user.id, 
      name: user.first_name + " " + user.last_name,
      user_type: user.user_type,
      email: user.email,
      status: user.status,
      user_created_at: user.created_at,
      user_updated_at: user.updated_at,
      administration_id: user.administration_id,
    )
  end
end