class Chat::Create < Trailblazer::Operation
  step :model!
  step Contract::Build(constant: Chat::Contract::Create)
  step Contract::Validate()
  step :create_chat

  def model!(results,message:, current_user:, to_group_id:, **)
    results[:model] = Chat.new(message: message, to_group_id: to_group_id, from_id: current_user.id, administration_id: current_user.administration_id)
  end
  def create_chat(results, **)
    results[:model].save
  end
end
