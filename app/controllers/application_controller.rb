class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:name, :member, :profile, :works)
    devise_parameter_sanitizer.for(:account_update).push(:name, :member, :profile, :works)
  end
end
