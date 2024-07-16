class Signing::CreateTeacher < Trailblazer::Operation
  step :model!
  step Contract::Build(constant: User::Contract::Create)
  step :assign_confirm_password
  step Contract::Validate()
  step Contract::Persist()

  def model!(result, user:, **)
    result[:model] = User.new(user.except(:confirm_password))
    result[:confirm_password] = user[:confirm_password]
  end

  def assign_confirm_password(result, **)
    result['contract.default'].confirm_password = result[:confirm_password]
  end

end