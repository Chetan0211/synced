class Admin::TeachersController < ApplicationController
  before_action :authenticate_user
  def index
    @page = (params[:page] || 1).to_i
    @page = @page<1? 1 : @page
    @total_teachers = teachers(params)
    @pages, @teachers =  Pagination.new(@total_teachers, @page-1).values
    @redirect_path = method(:admin_teachers_path)
    if request.xhr?
      teachers_html = render_to_string(partial: 'admin/teachers/teacher', collection: @teachers)
      pagination_html = render_to_string partial: 'common/pagination', locals:{total_count: @total_teachers.count}
      respond_to do |format|
        format.json do
          render json: { teachers: teachers_html, pagination: pagination_html}
        end
      end
    end
  end

  def sort(teachers)
    teachers.order(sort_column + ' ' + sort_direction)
  end

  private

  def teachers(params)
    teachers = Rails.cache.fetch("teacher_cache_#{@current_user.administration_id}") do 
      User.teachers(current_user)
    end
    if params[:start_date].present? && params[:end_date].present?
      teachers = teachers.where(created_at: DateTime.parse(params[:start_date])..DateTime.parse(params[:end_date]))
    end
    if params[:status].present?
      teachers = teachers.where(status: JSON.parse(params[:status]))
    end
    if params[:search_text].present?
      teachers = teachers.where("first_name ILIKE :search OR last_name ILIKE :search OR email ILIKE :search", search: "%#{params[:search_text]}%")
    end
    return sort(teachers)
  end

  def sort_column
    %w[email first_name last_name created_at].include?(params[:sort]) ? params[:sort] : 'created_at'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end