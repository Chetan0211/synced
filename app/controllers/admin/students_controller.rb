class Admin::StudentsController < ApplicationController
  def index
    @students = User.where(administration_id: current_user.administration_id, user_type: "student")
  end
end