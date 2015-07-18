class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include AuthenticationRedirect

  rescue_from CanCan::AccessDenied do
    redirect_to root_url, alert: t('flash.not_authorized')
  end

  private

  def current_user_participations
    Participation.where(user: current_user)
  end
end
