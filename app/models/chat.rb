class Chat < ApplicationRecord
  belongs_to :from, class_name: "User", foreign_key: "from_id"
  belongs_to :to_group, class_name: "Group", foreign_key: "to_group_id"
  belongs_to :administration
end
