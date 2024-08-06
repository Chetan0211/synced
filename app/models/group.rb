class Group < ApplicationRecord
  has_many :chats, class_name: "Chat", foreign_key: "to_group_id"
  has_many :group_users
end
