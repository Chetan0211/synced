class Admin::StudentsController < ApplicationController
  before_action :authenticate_user
  def index
    @page = (params[:page] || 1).to_i
    @page = @page<1? 1 : @page
    @total_students = User.where(administration_id: current_user.administration_id, user_type: "student")
    @pages = (@total_students.count/Float(10)).ceil
    @students = @total_students.offset((@page-1)*10).limit(10)
    @redirect_path = method(:admin_students_path)
  end
end