class ChatController < ApplicationController
  before_action :constructor

  def constructor
    @user_list = GroupUser.joins(:group, :user)
    .where(users: {administration_id: current_user.administration_id}, groups: {id: GroupUser.where(user_id: current_user.id).pluck(:group_id)})
    .where.not(users:{id: current_user.id})
  end
end
