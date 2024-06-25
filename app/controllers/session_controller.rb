class SessionController < ApplicationController
  def new
    @login_data = flash.now[:user_data] || {}
    @errors = flash.now[:errors] || {}
  end

  def create
    @login_data = params[:login_user] || {}
    @errors = {}
    session_status = Session::Create.call(login_user: session_params, session: session)
    if session_status.success?
      redirect_to root_path
    else
      flash.now[:user_data] = @login_data
      flash.now[:errors] = @errors = session_status[:model].errors
      render :new, status: :unprocessable_entity
    end
  end

  def log_out
    # Clear all session data
    reset_session

    redirect_to root_path
  end


  private

  def session_params
    params.require(:login_user).permit(:email, :password)
  end
end