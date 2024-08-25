class Teacher::ChatController < ChatController
  layout "chats/chat"
  def index
    unless params[:group].present?
      redirect_to teacher_nochat_path
    end
    @user = User.find_by(id: params[:user])
    @group = Group.find_by(id: params[:group])
    @chats = Chat.where(to_group_id: params[:group])
    @message_path = method(:teacher_chat_index_path)
  end

  def nochat
    
  end

  def create
    status = Chat::Create.call(message:params[:message], current_user: current_user, to_group_id: params[:group_id])
    if status.success?
      debugger
    else  
      debugger
    end
  end
end