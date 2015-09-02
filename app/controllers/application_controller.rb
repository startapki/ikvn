class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  include AuthenticationRedirect
  include DeviseConfiguration

  rescue_from CanCan::AccessDenied do
    redirect_to root_url, alert: t('flash.not_authorized')
  end

  private

  def current_user_participations
    Participation.where(user: current_user)
  end

  def additional_devise_permitted_params
    { account_update: [:name, :wants_email], sign_up: [:name] }
  end
end
