class Chat::Contract::Create < ApplicationContract
  model :chat

  property :message, type: String, null: false
  property :from_id, null: false
  property :to_group_id, null: false
  property :administration_id, null: false
end
