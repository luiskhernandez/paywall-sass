class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    # Fields for sign up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :domain, :subdomain, :email, :password])
  end

  def after_sign_in_path_for(resource)
    return accounts_dashboard_index_path(subdomain: resource.subdomain) if resource.class == Account
  end
end
