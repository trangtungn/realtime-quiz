class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :is_admin?

  private

  def authenticate_admin!
    return if is_admin?

    redirect_to root_path, alert: 'Access denied.'
  end

  def is_admin?
    current_user.admin?
  end
end
