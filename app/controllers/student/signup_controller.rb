class Student::SignupController < ApplicationController
  def new
    @path = method(:student_signup_index_path)
    @errors = flash.now[:errors] || {}
    @user_data = flash.now[:user_data] || {}
    @user_data[:email_identifier] = current_user.administration.email_identifier
  end
  def create
    @path = method(:student_signup_index_path)
    @user_data = user_params || {}
    user = user_params
    @errors = {}
    @user_data[:email_identifier] = current_user.administration.email_identifier
    user[:user_type] = "student"
    user[:email] = user[:email] + "@" + current_user.administration.email_identifier
    user[:administration_id] = current_user.administration_id
    result = Signing::CreateStudent.call(user: user)
    if result.success?
      redirect_to admin_students_path
    else
      flash.now[:user_data] = @user_data
      flash.now[:errors] = @errors = result['contract.default'].errors
      render :new, status: :unprocessable_entity
    end
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :personal_email, :email, :password, :confirm_password)
  end
end
