class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  helper_method :current_user, :logged_in?

  protected

  def authenticate_user!
    redirect_to login_path unless logged_in?
  end

  def current_user
    @current_user ||= if session[:user_id]
                        user = User.find(session[:user_id])
                        cookies.signed[:user_id] = user.id

                        user
                      end
  end

  private

  def logged_in?
    !!current_user
  end
end
