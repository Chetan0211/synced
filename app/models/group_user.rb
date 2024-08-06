class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user
  belongs_to :last_chat_seen, class_name: "Chat", foreign_key: "last_chat_seen_id"
end
