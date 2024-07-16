class Admin::TeachersController < ApplicationController
  def index
    @page = (params[:page] || 1).to_i
    @page = @page<1? 1 : @page
    @total_teachers = User.where(administration_id: current_user.administration_id, user_type: "teacher")
    @pages = (@total_teachers.count/Float(10)).ceil
    @teachers = @total_teachers.offset((@page-1)*10).limit(10)
    @redirect_path = method(:admin_teachers_path)
  end

  def sort
    @total_teachers = User.order(sort_column + ' ' + sort_direction).where(administration_id: current_user.administration_id, user_type: "teacher")
    respond_to do |format|
      format.js
    end
  end

  private

  def sort_column
    %w[email first_name last_name created_at].include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end