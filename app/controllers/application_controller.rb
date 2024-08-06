class ApplicationController < ActionController::Base
  before_action :current_user
  before_action :check_logo_redirect_path

  def current_user
    @current_user = User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def check_logo_redirect_path
    if current_user.present?
      if current_user.admin?
        @logo_redirect = method(:admin_dashboard_path)
      elsif current_user.teacher?
        @logo_redirect = method(:teacher_dashboard_path)
      elsif current_user.student?
        @logo_redirect = method(:student_dashboard_path)
      else
        @logo_redirect = method(:root_path)
      end
    else
      @logo_redirect = method(:root_path)
    end
  end

  def authenticate_user
    if current_user.nil?
      redirect_to root_path
    end
  end
end
