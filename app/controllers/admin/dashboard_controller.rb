class Admin::DashboardController < ApplicationController
  
  before_action :set_administration
  before_action ->{authorize! :manage, @administration}
  def index
  end

  private

  def set_administration
    @administration = Administration.find(current_user.administration_id)
  end
end
