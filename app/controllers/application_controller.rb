class ApplicationController < ActionController::Base
  before_action :current_user

  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id].present?
    unless @current_user
      redirect_to sign_in_path
    end
  end
end
