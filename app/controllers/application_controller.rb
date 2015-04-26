class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery with: :exception
  layout :layout_by_resource

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :role
  end

  def layout_by_resource
    if devise_controller?
      "empty"
    else
      "application"
    end
  end
end
