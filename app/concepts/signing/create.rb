class Signing::Create < Trailblazer::Operation
  step :model!
  step Contract::Build(constant: Signing::Contract::UserCreate)
  step :assign_confirm_password
  step Contract::Validate()
  step :save_user_with_administration

  private

  def model!(result, user:, administration:, **)
    result[:model] = {
      user: User.new(user.except(:confirm_password)),
      administration: Administration.new(administration)
    }

    result[:confirm_password] = user[:confirm_password]
  end

  def assign_confirm_password(result, **)
    result['contract.default'].confirm_password = result[:confirm_password]
  end

  def save_user_with_administration(result, **)
    result[:model][:administration].save do
      result[:model][:user].update(administration_id: result[:model][:administration].id)
      result[:model][:user].save
    end
  end
end