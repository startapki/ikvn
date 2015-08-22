class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include AuthenticationRedirect

  rescue_from CanCan::AccessDenied do
    redirect_to root_url, alert: t('flash.not_authorized')
  end

  private

  def current_user_participations
    Participation.where(user: current_user)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) << :wants_email
  end
end
