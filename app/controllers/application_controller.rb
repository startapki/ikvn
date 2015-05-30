class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include AuthenticationRedirect

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: t('flash.not_authorized')
  end
end
